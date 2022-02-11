#!/bin/bash
set -x
parallel-ssh  -i --hosts hosts.txt -x "-oStrictHostKeyChecking=no  -i aleo.pem" 'rm miner*zip'
parallel-ssh  -i --hosts hosts.txt -x "-oStrictHostKeyChecking=no  -i aleo.pem" 'sudo rm /etc/systemd/system/jobclient.service'
parallel-ssh  -i --hosts hosts.txt -x "-oStrictHostKeyChecking=no  -i aleo.pem" 'sudo rm -r /opt/pool-client'
parallel-ssh  -i --hosts hosts.txt -x "-oStrictHostKeyChecking=no  -i aleo.pem" 'rm -r pool-client'
parallel-ssh  -i --hosts hosts.txt -x "-oStrictHostKeyChecking=no  -i aleo.pem" 'ls'