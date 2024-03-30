# Install Airflow

Installing Airflow
##### -  Create and start a docker container from the Docker image python:3.10.13-slim-bullseye and execute the command /bin/bash in order to have a shell session <br>
`docker run -it --rm -p 8080:8080 python:3.10.13-slim-bullseye /bin/bash`

##### -  Print the Python version <br>
`python -V`

##### -  Export the environment variable AIRFLOW_HOME used by Airflow to store the dags folder, logs folder and configuration file <br>
`export AIRFLOW_HOME=/usr/local/airflow`


##### -  To check that the environment variable has been well exported <br>
`env | grep airflow`

##### -  Install all tools and dependencies that can be required by Airflow <br>
`apt-get update -y && apt-get install -y wget libczmq-dev curl libssl-dev git inetutils-telnet bind9utils freetds-dev libkrb5-dev libsasl2-dev libffi-dev libpq-dev freetds-bin build-essential default-libmysqlclient-dev apt-utils rsync zip unzip gcc && apt-get clean`


##### -  Create the user airflow, set its home directory to the value of AIRFLOW_HOME and log into it <br>
`useradd -ms /bin/bash -d ${AIRFLOW_HOME} airflow`


##### -  Show the file /etc/passwd to check that the airflow user has been created <br>
`cat /etc/passwd | grep airflow`



##### -  Upgrade pip (already installed since we use the Docker image python 3.5) <br>
`pip install --upgrade pip`

##### -  Log into airflow <br>
`su - airflow`

##### -  Create the virtual env named sandbox  <br>
`python -m venv .sandbox`

##### -  Activate the virtual environment sandbox <br>
`source .sandbox/bin/activate`

##### -  Quick Start <br>
https://airflow.apache.org/docs/apache-airflow/stable/start.html <br>


##### -  Download the requirement file to install the right version of Airflow’s dependencies <br>
`export AIRFLOW_VERSION=2.8.1` <br>
`export PYTHON_VERSION="$(python --version | cut -d " " -f 2 | cut -d "." -f 1-2)"` <br>
`export CONSTRAINT_URL="https://raw.githubusercontent.com/apache/airflow/constraints-${AIRFLOW_VERSION}/constraints-${PYTHON_VERSION}.txt"` <br>

##### -  Install the version 2.0.2 of apache-airflow with all subpackages defined between square brackets. (Notice that you can still add subpackages after all, you will use the same command with different subpackages even if Airflow is already installed) <br>
https://airflow.apache.org/docs/apache-airflow/stable/installation/installing-from-pypi.html <br>
`pip install "apache-airflow[crypto,celery,postgres,cncf.kubernetes,docker]==${AIRFLOW_VERSION}" --constraint "https://raw.githubusercontent.com/apache/airflow/constraints-${AIRFLOW_VERSION}/constraints-${PYTHON_VERSION}.txt"` <br>

##### -  Initialise the metadatabase <br>
`airflow db init`

##### -  Create admin user <br>
`airflow users create -u admin -f admin -l admin -r Admin -e admin@airflow.com -p admin` <br>


##### -  Start Airflow’s scheduler in background <br>
`airflow scheduler &`


##### -  Start Airflow’s webserver in background <br>
`airflow webserver &`

`docker build -t airflow-basic .`
##### -  Build a docker image from the Dockerfile in the current directory (airflow-materials/airflow-basic)  and name it airflow-basic <br>

`docker run --rm -d -p 8080:8080 airflow-basic`


# Quick Tour of Airflow CLI

docker ps
##### -  Show running docker containers


docker exec -it container_id /bin/bash
##### -  Execute the command /bin/bash in the container_id to get a shell session


pwd
##### -  Print the current path where you are


airflow db init
##### -  Initialise the metadatabase


airflow db reset
##### -  Reinitialize the metadatabase (Drop everything)


airflow db upgrade
##### -  Upgrade the metadatabase (Latest schemas, values, ...)


airflow webserver
##### -  Start Airflow’s webserver


airflow scheduler
##### -  Start Airflow’s scheduler


airflow celery worker
##### -  Start a Celery worker (Useful in distributed mode to spread tasks among nodes - machines)


airflow dags list
##### -  Give the list of known dags (either those in the examples folder or in dags folder)


ls
##### -  Display the files/folders of the current directory 


airflow dags trigger example_python_operator
##### -  Trigger the dag example_python_operator with the current date as execution date


airflow dags trigger example_python_operator -e 2021-01-01
##### -  Trigger the dag example_python_operator with a date in the past as execution date (This won’t trigger the tasks of that dag unless you set the option catchup=True in the DAG definition)


airflow dags trigger example_python_operator -e '2021-01-01 19:04:00+00:00'
##### -  Trigger the dag example_python_operator with a date in the future (change the date here with one having +2 minutes later than the current date displayed in the Airflow UI). The dag will be scheduled at that date.


airflow dags list-runs -d example_python_operator
##### -  Display the history of example_python_operator’s dag runs


airflow tasks list example_python_operator
##### -  List the tasks contained into the example_python_operator dag


airflow tasks test example_python_operator print_the_context 2021-01-01
##### -  Allow to test a task (print_the_context) from a given dag (example_python_operator here) without taking care of dependencies and past runs. Useful for debugging.
