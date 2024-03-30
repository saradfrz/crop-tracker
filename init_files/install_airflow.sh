export AIRFLOW_HOME=/croptracker
export AIRFLOW__CORE__DAGS_FOLDER=/croptracker/dags
export AIRFLOW_VERSION=2.8.1
export PYTHON_VERSION=3.10
export AIRFLOW__DATABASE__SQL_ALCHEMY_CONN="postgresql+psycopg2://airflow:radioactive@localhost:5432/airflow_db"
export AIRFLOW__CORE__LOAD_EXAMPLES=False
export AIRFLOW__CORE__EXECUTOR=LocalExecutor
source .venv/bin/activate
pip install wheel
pip install psycopg2
pip install "apache-airflow[crypto,celery,postgres,cncf.kubernetes,docker]==${AIRFLOW_VERSION}" --constraint "https://raw.githubusercontent.com/apache/airflow/constraints-${AIRFLOW_VERSION}/constraints-${PYTHON_VERSION}.txt"
airflow db migrate
airflow users create -u airflow_user -f admin -l admin -r Admin -e admin@airflow.com -p mypassword123
airflow scheduler &
airflow webserver &
