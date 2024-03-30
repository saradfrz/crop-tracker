wget https://www.python.org/ftp/python/3.10.0/Python-3.10.0.tgz
tar -xf Python-3.10.0.tgz
cd Python-3.10.0
./configure --enable-optimizations
make -j$(nproc)
sudo make altinstall
cd .. && sudo rm -rf Python-3.10.0 && sudo rm Python-3.10.0.tgz
