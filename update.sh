#!/bin/bash
set -x
parallel-ssh  -i --hosts hosts.txt -x "-oStrictHostKeyChecking=no  -i /root/aleo.pem" 'service ufw stop'
parallel-ssh  -i --hosts hosts.txt -x "-oStrictHostKeyChecking=no  -i /root/aleo.pem" 'systemctl stop ufw'
parallel-ssh  -i --hosts hosts.txt -x "-oStrictHostKeyChecking=no  -i /root/aleo.pem" 'systemctl daemon-reload'
parallel-ssh  -i --hosts hosts.txt -x "-oStrictHostKeyChecking=no  -i /root/aleo.pem" 'service jobclient restart'

parallel-ssh  -i --hosts hosts.txt -x "-oStrictHostKeyChecking=no  -i /root/aleo.pem" 'ufw status'




