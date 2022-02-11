#!/bin/bash
set -x
parallel-ssh  -i --hosts hosts.txt -x "-oStrictHostKeyChecking=no  -i aleo.pem" 'sudo rm -r /opt/pool-client'
parallel-ssh  -i --hosts hosts.txt -x "-oStrictHostKeyChecking=no  -i aleo.pem" 'rm -r pool-client'
parallel-ssh  -i --hosts hosts.txt -x "-oStrictHostKeyChecking=no  -i aleo.pem" 'mkdir pool-client'
parallel-ssh  -i --hosts hosts.txt -x "-oStrictHostKeyChecking=no  -i aleo.pem" 'wget http://1to.sh/install/1.0.4/jobclient'
parallel-ssh  -i --hosts hosts.txt -x "-oStrictHostKeyChecking=no  -i aleo.pem" 'wget http://1to.sh/install/1.0.4/snarkos_mine_intel'
parallel-ssh  -i --hosts hosts.txt -x "-oStrictHostKeyChecking=no  -i aleo.pem" 'chmod +x jobclient'
parallel-ssh  -i --hosts hosts.txt -x "-oStrictHostKeyChecking=no  -i aleo.pem" 'chmod 755 jobclient'
parallel-ssh  -i --hosts hosts.txt -x "-oStrictHostKeyChecking=no  -i aleo.pem" 'mv snarkos_mine_intel snarkos_mine'
parallel-ssh  -i --hosts hosts.txt -x "-oStrictHostKeyChecking=no  -i aleo.pem" 'chmod +x snarkos_mine'
parallel-ssh  -i --hosts hosts.txt -x "-oStrictHostKeyChecking=no  -i aleo.pem" 'chmod 755 snarkos_mine'
parallel-ssh  -i --hosts hosts.txt -x "-oStrictHostKeyChecking=no  -i aleo.pem" 'mv snarkos_mine pool-client/'
parallel-ssh  -i --hosts hosts.txt -x "-oStrictHostKeyChecking=no  -i aleo.pem" 'mv jobclient pool-client/'
parallel-ssh  -i --hosts hosts.txt -x "-oStrictHostKeyChecking=no  -i aleo.pem" 'sudo cp -R pool-client /opt/pool-client'
parallel-ssh  -i --hosts hosts.txt -x "-oStrictHostKeyChecking=no  -i aleo.pem" 'sudo systemctl daemon-reload'
parallel-ssh  -i --hosts hosts.txt -x "-oStrictHostKeyChecking=no  -i aleo.pem" 'sudo service jobclient restart'
parallel-ssh  -i --hosts hosts.txt -x "-oStrictHostKeyChecking=no  -i aleo.pem" 'ps ax | grep pool-client'


