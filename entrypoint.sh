#!/bin/bash
set -e

# Автоматично визначаємо JAVA_HOME (працює і на amd64, і на arm64)
if ! command -v java >/dev/null 2>&1; then
  echo "java not found in PATH"
  exit 1
fi

JAVA_BIN="$(readlink -f "$(command -v java)")"
export JAVA_HOME="$(dirname "$(dirname "$JAVA_BIN")")"
export PATH="$JAVA_HOME/bin:$PATH"
echo "JAVA_HOME=${JAVA_HOME}"

SPARK_WORKLOAD="${1:-}"
echo "SPARK_WORKLOAD: ${SPARK_WORKLOAD}"

case "${SPARK_WORKLOAD}" in
  master)
    start-master.sh -p 7077
    ;;
  worker|worker-*)
    start-worker.sh spark://spark-master:7077
    ;;
  history)
    start-history-server.sh
    ;;
  "" )
    exec bash
    ;;
  * )
    exec "$@"
    ;;
esac

# Тримаємо контейнер живим (бо start-*.sh запускають daemon і виходять)
tail -f /dev/null