# Crop Tracker

Crop Tracker is an Apache Airflow-based project designed to compile news on crops and the agroindustry.

## Overview

## Features

## Getting Started

## Dependencies

- Apache Airflow
- Python libraries

## Contributing

Contributions to CyberTinker are welcome! If you encounter any issues, have suggestions for improvements, or would like to contribute new features, please feel free to submit a pull request or open an issue on GitHub.


# Install Airflow

## Setup the OS

1. Install WSL <br>
```
wsl --unregister Ubuntu-04
```
```
wsl --install Ubuntu-04
```
```
Enter new UNIX username: <windows_user>
```
## Configure Linux 
Customize and execute the file `init_files/configure_linux.sh` <br>
https://github.com/saradfrz/crop-tracker/blob/main/init_files/configure_linux.sh <br>
```
touch configure_linux.sh
nano configure_linux.sh
sudo bash configure_linux.sh
```
https://github.com/settings/keys

## Install Python from Source
```
cd /croptracker
sudo bash init_files/install_python_from_source.sh
```

## Install Postgres
Install Postgres from Apt repository<br>

```bash 
sudo bash init_files/install_postgres.sh
```
```sql
ALTER USER postgres WITH PASSWORD 'new_password';
```
```sql
CREATE DATABASE airflow_db;
```
```sql
CREATE USER airflow WITH PASSWORD 'airflow_password';
```
`ctr + z` <br>
```bash
psql -d airflow_db
```
```sql
GRANT ALL PRIVILEGES ON DATABASE airflow_db TO airflow;
```
```sql
GRANT ALL PRIVILEGES ON SCHEMA public TO airflow;
```
```sql
ALTER DATABASE airflow_db OWNER TO airflow
```
`ctr + z`<br>
```bash
su <windows_user>
sudo nano  /etc/postgresql/main/pg_hba.conf
```
**Add the following line** <br>
```
host    all             airflow         .0.0.1/           scram-sha-
```
#### Useful commands <br>
```bash
# Open pg_hba.config
sudo nano  /etc/postgresql/main/pg_hba.config
```
```bash
# Restart service
sudo service postgresql restart
```
```bash
# Login
psql -U username -d database_name -h hostname -p port
```

## Install Airflow

```bash
sudo apt update && sudo apt upgrade
python3.-m venv .venv
source .venv/bin/activate
```
```bash
sudo bash -c "./init_files/install_airflow.sh; exec bash"
```

In case of error:
```bash
psql -U postgres -d airflow_db -h localhost -p 2
```


## Next uses
```bash 
sudo bash -c "./start.sh; exec bash"
```

# Troubleshoot <br>

## Restart
```
kill $(ps aux | grep '/home/airflow/.venv/bin/python3. | grep -v grep | awk '{print $2}')
export AIRFLOW__DATABASE__SQL_ALCHEMY_CONN="postgresql+psycopg2://airflow:radioactive@localhost:2/airflow_db" && export AIRFLOW__CORE__LOAD_EXAMPLES=False && export AIRFLOW__CORE__EXECUTOR=LocalExecutor
airflow scheduler &
airflow webserver &
```
