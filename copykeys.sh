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

#copy public key to file
cat ~/.ssh/id_rsa.pub >> authorized_keys

#send public key file to remote system
scp -P $port ~/.ssh/authorized_keys $user@$ip:~/.ssh/

#exit with same exit code as above command
exitCode=$?
echo "exit $exitCode"
exit $exitCode

