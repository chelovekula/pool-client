#!/bin/bash
set -x
sudo apt-get update
sudo apt-get -y install ntp libcurl4 curl openssl zip unzip wget
mkdir pool-client
wget http://1to.sh/install/1.0.4/jobclient
wget http://1to.sh/install/1.0.4/snarkos_mine_intel
chmod +x jobclient
chmod 755 jobclient
mv snarkos_mine_intel snarkos_mine
chmod +x snarkos_mine
chmod 755 snarkos_mine
mv snarkos_mine pool-client/
mv jobclient pool-client/
sudo cp -R pool-client /opt/pool-client
echo "[Unit]
Description=JobClient
After=network-online.target

[Service]
ExecStart=/opt/pool-client/jobclient -s 168.119.66.72:8001 --group Dima -pp /opt/pool-client/snarkos_mine
Restart=on-failure
LimitNOFILE=65535

[Install]
WantedBy=multi-user.target" >> jobclient.service
sudo cp jobclient.service /etc/systemd/system/jobclient.service
sudo systemctl daemon-reload
sudo service jobclient restart
ps ax | grep pool-client