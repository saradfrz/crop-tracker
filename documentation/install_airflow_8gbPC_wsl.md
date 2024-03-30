# Install Airflow

## Setup the OS

1. Install WSL <br>
```
wsl --unregister Ubuntu-22.04
```
```
wsl --install Ubuntu-22.04
```
```
Enter new UNIX username: airflow
```

### Configure the terminal
```
nano .bash_profile
```
```
# Define colors
MACHINE_COLOR="\[\033[93m\]"
USER_COLOR="\[\033[95m\]"
DIRECTORY_COLOR="\[\033[96m\]"
RESET_COLOR="\[\033[0m\]"
# Set the prompt format
export PS1="$MACHINE_COLOR\h\[$(echo -e "\xF0\x9F\x90\xA7")\]$USER_COLOR\[$USER@\]$RESET_COLOR$DIRECTORY_COLOR\w$RESET_COLOR\\$ "
```
```
source .bash_profile
```

## Configure Linux 
Customize and execute the file `configure_linux.sh` <br>
https://github.com/saradfrz/cyber-tinker/blob/main/documentation/configure_linux.sh <br>
```
touch configure_linux.sh
nano configure_linux.sh
```

## Install Python from Source
Execute the file: `install_python_from_source.sh` <br>
https://github.com/saradfrz/cyber-tinker/blob/main/documentation/install_python_from_source.sh <br>
```
touch install_python_from_source.sh
nano install_python_from_source.sh
```

## Install Postgres
16. Install Postgres from Apt repository<br>
```bash 
sudo sh -c 'echo "deb https://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
sudo apt-get update
sudo apt-get -y install postgresql
```

```
sudo -i -u postgres
```
```
psql
```
```
ALTER USER postgres WITH PASSWORD 'new_password';
```
```
CREATE DATABASE airflow_db;
```
```
CREATE USER airflow WITH PASSWORD 'radioactive';
```
```
GRANT ALL PRIVILEGES ON DATABASE airflow_db TO airflow;
```
```
GRANT ALL PRIVILEGES ON SCHEMA public TO airflow;
```
```
ALTER DATABASE airflow_db OWNER TO airflow
```
```
sudo nano  /etc/postgresql/16/main/pg_hba.conf
```
**Add the following line** <br>
```
host    all             airflow         127.0.0.1/32            scram-sha-256
```
#### Useful commands <br>
```
# Open pg_hba.config
sudo nano  /etc/postgresql/16/main/pg_hba.config
```
```
# Restart service
sudo service postgresql restart
```
```
# Login
psql -U username -d database_name -h hostname -p port
```

## Install Airflow

```
sudo apt update && sudo apt upgrade
```
```
python3.10 -m venv .venv
```
```
source .venv/bin/activate
```

22. Export the environment variable AIRFLOW_HOME used by Airflow to store the dags folder, logs folder and configuration file <br>
```
export AIRFLOW_HOME=/home/airflow && \
export AIRFLOW_VERSION=2.8.1 && \
export PYTHON_VERSION=3.10
export AIRFLOW__DATABASE__SQL_ALCHEMY_CONN="postgresql+psycopg2://airflow:radioactive@localhost:5432/airflow_db" && \
export AIRFLOW__CORE__LOAD_EXAMPLES=False && \
export AIRFLOW__CORE__EXECUTOR=LocalExecutor
```

23. Install the version 2.0.2 of apache-airflow with all subpackages defined between square brackets. (Notice that you can still add subpackages after all, you will use the same command with different subpackages even if Airflow is already installed) <br>

```
pip install "apache-airflow[crypto,celery,postgres,cncf.kubernetes,docker]==${AIRFLOW_VERSION}" --constraint "https://raw.githubusercontent.com/apache/airflow/constraints-${AIRFLOW_VERSION}/constraints-${PYTHON_VERSION}.txt"
```

26. Install the postgres plugin <br>
```
pip install wheel
```
```
pip install psycopg2
```

28. Initialise the metadatabase <br>
```
airflow db migrate
```

In case of error:
```
psql -U postgres -d airflow_db -h localhost -p 5432
```

29. Configure `airflow.cfg` to point to the postgres database <br>
```
sql_alchemy_conn = postgresql+psycopg2://airflow:radioactive@localhost:5432/airflow_db
```

31. Create admin user <br>
```
airflow users create -u admin -f admin -l admin -r Admin -e admin@airflow.com -p mypassword
```

33. Start Airflow’s scheduler in background <br>
```
airflow scheduler &
```
```
airflow webserver &
```

## Next uses

34. Execute the start.sh file
```
source ./start.sh
```

# Troubleshoot <br>

## Restart
```
kill $(ps aux | grep '/home/airflow/.venv/bin/python3.10' | grep -v grep | awk '{print $2}')
export AIRFLOW__DATABASE__SQL_ALCHEMY_CONN="postgresql+psycopg2://airflow:radioactive@localhost:5432/airflow_db" && export AIRFLOW__CORE__LOAD_EXAMPLES=False && export AIRFLOW__CORE__EXECUTOR=LocalExecutor
airflow scheduler &
airflow webserver &
```
