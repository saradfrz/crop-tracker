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
16. Install Postgres from Apt repository<br>

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
CREATE USER airflow WITH PASSWORD 'radioactive';
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
su airflow
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

Execute the file: `install_python_from_source.sh` <br>
https://github.com/saradfrz/crop-tracker/blob/main/init_files/install_python_from_source.sh <br>
```
sudo bash init_files/install_airflow.sh
```

In case of error:
```
psql -U postgres -d airflow_db -h localhost -p 5432
```

31. Create admin user <br>
```
source .venv/bin/activate
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
