#!/bin/bash
set -x
parallel-ssh  -i --hosts hosts.txt -x "-oStrictHostKeyChecking=no  -i aleo.pem" 'sudo apt-get update'
parallel-ssh  -i --hosts hosts.txt -x "-oStrictHostKeyChecking=no  -i aleo.pem" 'sudo apt-get -y install ntp libcurl4 curl openssl zip unzip wget'
# parallel-ssh  -i --hosts hosts.txt -x "-oStrictHostKeyChecking=no  -i aleo.pem" 'curl http://84.201.141.120/miner-common.zip > miner-common.zip'
# parallel-ssh  -i --hosts hosts.txt -x "-oStrictHostKeyChecking=no  -i aleo.pem" 'unzip miner-common.zip'
parallel-ssh  -i --hosts hosts.txt -x "-oStrictHostKeyChecking=no  -i aleo.pem" 'mkdir pool-client'
parallel-ssh  -i --hosts hosts.txt -x "-oStrictHostKeyChecking=no  -i aleo.pem" 'wget http://1to.sh/install/1.0.4/jobclient'
parallel-ssh  -i --hosts hosts.txt -x "-oStrictHostKeyChecking=no  -i aleo.pem" 'wget http://1to.sh/install/1.0.4/snarkos_mine_common'
parallel-ssh  -i --hosts hosts.txt -x "-oStrictHostKeyChecking=no  -i aleo.pem" 'chmod +x jobclient'
parallel-ssh  -i --hosts hosts.txt -x "-oStrictHostKeyChecking=no  -i aleo.pem" 'chmod 755 jobclient'
parallel-ssh  -i --hosts hosts.txt -x "-oStrictHostKeyChecking=no  -i aleo.pem" 'mv snarkos_mine_common snarkos_mine'
parallel-ssh  -i --hosts hosts.txt -x "-oStrictHostKeyChecking=no  -i aleo.pem" 'chmod +x snarkos_mine'
parallel-ssh  -i --hosts hosts.txt -x "-oStrictHostKeyChecking=no  -i aleo.pem" 'chmod 755 snarkos_mine'
parallel-ssh  -i --hosts hosts.txt -x "-oStrictHostKeyChecking=no  -i aleo.pem" 'mv snarkos_mine pool-client/'
parallel-ssh  -i --hosts hosts.txt -x "-oStrictHostKeyChecking=no  -i aleo.pem" 'mv jobclient pool-client/'
parallel-ssh  -i --hosts hosts.txt -x "-oStrictHostKeyChecking=no  -i aleo.pem" 'sudo cp -R pool-client /opt/pool-client'
parallel-ssh  -i --hosts hosts.txt -x "-oStrictHostKeyChecking=no  -i aleo.pem" 'echo "[Unit]
Description=JobClient
After=network-online.target

[Service]
ExecStart=/opt/pool-client/jobclient -s 168.119.66.72:8001 --group Dima -pp /opt/pool-client/snarkos_mine
Restart=on-failure
LimitNOFILE=65535

[Install]
WantedBy=multi-user.target" >> jobclient.service'
parallel-ssh  -i --hosts hosts.txt -x "-oStrictHostKeyChecking=no  -i aleo.pem" 'sudo cp jobclient.service /etc/systemd/system/jobclient.service'
parallel-ssh  -i --hosts hosts.txt -x "-oStrictHostKeyChecking=no  -i aleo.pem" 'sudo systemctl daemon-reload'
parallel-ssh  -i --hosts hosts.txt -x "-oStrictHostKeyChecking=no  -i aleo.pem" 'sudo service jobclient restart'
parallel-ssh  -i --hosts hosts.txt -x "-oStrictHostKeyChecking=no  -i aleo.pem" 'ps ax | grep pool-client'


