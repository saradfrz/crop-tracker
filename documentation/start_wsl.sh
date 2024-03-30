sudo apt update && sudo apt upgrade
sudo apt install -y build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libsqlite3-dev libreadline-dev libffi-dev wget libbz2-dev && sudo apt install build-essential zlib1g-dev libffi-dev && sudo apt-get update -y && sudo apt-get install -y wget libczmq-dev curl libssl-dev git inetutils-telnet bind9utils freetds-dev libkrb5-dev libsasl2-dev libffi-dev libpq-dev freetds-bin build-essential default-libmysqlclient-dev apt-utils rsync zip unzip gcc && sudo apt-get clean
wget https://www.python.org/ftp/python/3.10.0/Python-3.10.0.tgz
tar -xf Python-3.10.0.tgz
cd Python-3.10.0
./configure --enable-optimizations
make -j$(nproc)
sudo make altinstall
cd .. && sudo rm -rf Python-3.10.0 && sudo rm Python-3.10.0.tgz
ssh-keygen -t ed25519 -C ""
git config --global user.email ""
git config --global user.name ""
sudo mkdir /airflow
sudo chmod -R 777 /airflow
sudo apt-get update -y && sudo sh -c 'echo "deb https://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
sudo apt-get update
sudo apt-get -y install postgresql
sudo apt update && sudo apt upgrade
