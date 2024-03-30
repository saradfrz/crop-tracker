sudo apt update && sudo apt upgrade
python3.10 -m venv .venv
source .venv/bin/activate
export AIRFLOW_HOME=/home/airflow
export AIRFLOW_VERSION=2.8.1
export PYTHON_VERSION=3.10
export AIRFLOW__DATABASE__SQL_ALCHEMY_CONN="postgresql+psycopg2://airflow:radioactive@localhost:5432/airflow_db"
export AIRFLOW__CORE__LOAD_EXAMPLES=False
export AIRFLOW__CORE__EXECUTOR=LocalExecutor
pip install wheel
pip install psycopg2
pip install "apache-airflow[crypto,celery,postgres,cncf.kubernetes,docker]==${AIRFLOW_VERSION}" --constraint "https://raw.githubusercontent.com/apache/airflow/constraints-${AIRFLOW_VERSION}/constraints-${PYTHON_VERSION}.txt"
airflow db migrate
