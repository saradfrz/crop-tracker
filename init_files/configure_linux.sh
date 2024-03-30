sudo apt update && sudo apt upgrade
sudo apt install -y build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libsqlite3-dev libreadline-dev libffi-dev wget libbz2-dev && sudo apt install build-essential zlib1g-dev libffi-dev && sudo apt-get update -y && sudo apt-get install -y wget libczmq-dev curl libssl-dev git inetutils-telnet bind9utils freetds-dev libkrb5-dev libsasl2-dev libffi-dev libpq-dev freetds-bin build-essential default-libmysqlclient-dev apt-utils rsync zip unzip gcc && sudo apt-get clean
ssh-keygen -t ed25519 -C "your_email@example.com"
git config --global user.email "your_email@example.com"
git config --global user.name "Your Name"
sudo nano  /root/.ssh/id_ed25519.pub
sudo mkdir /airflow/croptracker
sudo chmod -R 777 /airflow/croptracker
cd /home/croptracker
git clone git@github.com:saradfrz/crop-tracker.git .
git config --global --add safe.directory /airflow/croptracker
