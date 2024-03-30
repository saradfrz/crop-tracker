kill $(ps aux | grep '/home/airflow/.venv/bin/python3.10' | grep -v grep | awk '{print $2}')


