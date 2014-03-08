#!/bin/bash

echo "***************************"
echo "   Copy SSH ID to Remote   "
echo "***************************"

dport=22
duser=$(whoami)


#get remote system info
read -p "Enter remote IP address : " ip
read -p "Enter remote PORT to connect to : [press enter for port $dport] :" port
port=${port:-$dport}
read -p "Enter the username you wish to connect as : [press enter to use $duser] :" user
user=${user:-$duser}

echo "going to append public key to port $port at $user@$ip"

#append public key file to remote system
cat ~/.ssh/id_rsa.pub | ssh $user@$ip -p $port 'umask 077; cat >>.ssh/authorized_keys'

#exit with same exit code as above command
exitCode=$?
if [[ $exitCode -gt 0 ]]; then
  echo "Something went terribly wrong!!!!"
  echo "Exit Code : $exitCode"
  exit $exitCode
else
  echo "Successfully copied public key to remote machine!!!!"
  exit $?
fi
