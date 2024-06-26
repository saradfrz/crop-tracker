sudo chmod -R 777 /croptracker && \
export AIRFLOW_HOME=/croptracker && \
export AIRFLOW__CORE__DAGS_FOLDER=/croptracker/dags && \
export AIRFLOW_VERSION=2.8.1 && \
export PYTHON_VERSION=3.10 && \
export AIRFLOW__DATABASE__SQL_ALCHEMY_CONN="postgresql+psycopg2://airflow:${AIRFLOW_DATABASE_PASSWORD}@localhost:5432/airflow_db" && \
export AIRFLOW__CORE__LOAD_EXAMPLES=False && \
export AIRFLOW__CORE__EXECUTOR=LocalExecutor
airflow scheduler &
airflow webserver &