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
chmod 644 authorized_keys

echo "going to copy to port $port at $user@$ip"
#send public key file to remote system
scp -P $port authorized_keys $user@$ip:~/.ssh/

#exit with same exit code as above command
exitCode=$?
if [[ $exitCode -gt 0 ]]; then
  echo "Something went terribly wrong!!!!"
  echo "Cleaning up files..."
  rm authorized_keys
  echo "Exit Code : $exitCode"
  exit $exitCode
else
  echo "Successfully copied public key to remote machine!!!!"
  echo "Cleaning up files..."
  rm authorized_keys
  exit $?
fi
