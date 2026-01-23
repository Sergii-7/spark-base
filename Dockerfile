FROM python:3.12.9-bullseye AS spark-base

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      sudo \
      curl \
      vim \
      unzip \
      rsync \
      openjdk-11-jdk \
      build-essential \
      software-properties-common \
      ssh && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

ENV SPARK_VERSION=3.5.5

ENV SPARK_HOME="/opt/spark"
ENV HADOOP_HOME="/opt/hadoop"
ENV PATH="$PATH:$SPARK_HOME/bin:$SPARK_HOME/sbin"

ENV SPARK_MASTER_PORT=7077
ENV SPARK_MASTER_HOST=spark-master
ENV SPARK_MASTER="spark://$SPARK_MASTER_HOST:$SPARK_MASTER_PORT"

ENV PYTHONPATH=$SPARK_HOME/python/:$PYTHONPATH
ENV PYSPARK_PYTHON=python3

RUN mkdir -p ${HADOOP_HOME} ${SPARK_HOME}
WORKDIR ${SPARK_HOME}

RUN curl -fsSL https://archive.apache.org/dist/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop3.tgz \
      -o /tmp/spark.tgz \
    && tar -xzf /tmp/spark.tgz --directory ${SPARK_HOME} --strip-components 1 \
    && rm -f /tmp/spark.tgz

RUN chmod u+x /opt/spark/sbin/* && \
    chmod u+x /opt/spark/bin/*

COPY ./spark-defaults.conf "$SPARK_HOME/conf/"
COPY ./entrypoint.sh "$SPARK_HOME/entrypoint.sh"
RUN chmod +x "$SPARK_HOME/entrypoint.sh"

FROM spark-base AS jupyter-base

WORKDIR /opt/workspace

COPY requirements.txt /tmp/requirements.txt
RUN pip install --upgrade pip && \
    pip install --no-cache-dir -r /tmp/requirements.txt


EXPOSE 8889

ENTRYPOINT ["/opt/spark/entrypoint.sh"]
CMD ["bash"]