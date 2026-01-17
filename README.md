# spark-base
### Робота із структурованими даними за допомогою SparkSQL та PySpark. Частина 1

## 1) Встановити Java 17 (JDK)
Переконайся, що Java 17 встановлена і доступна:
```bash
java -version
```

#### Cloning the repository https://github.com/Sergii-7/spark-base.git

#### Environment setup
```bash
python -m venv venv
source venv/bin/activate  # Linux/MacOS
```

#### Установка залежностей
```bash
pip install -r requirements.txt
```

#### Перевірити PySpark
```bash
python -c "from pyspark.sql import SparkSession; spark = SparkSession.builder.master('local[3]').getOrCreate(); print(spark.version); spark.stop()"
```

#### Запустити Jupyter
```bash
jupyter lab
```

#### Відкрий Jupyter Lab у браузері.
#### В дереві файлів знайди та відкрий ноутбук spark_home_work.ipynb.
#### Запусти комірки:
	•	по черзі (Shift + Enter), або
	•	одним кліком: Kernel → Restart Kernel and Run All Cells (перезапустить kernel і виконає все з початку).

#### Рекомендація: якщо щось “поїхало” або з’явилися дивні помилки після правок — використовуй саме Restart Kernel and Run All Cells.