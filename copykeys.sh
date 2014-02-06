#!/bin/bash

echo "***************************"
echo "   Copy SSH ID to Remote   "
echo "***************************"

dport=22
duser=$(whoami)

echo "This script requires the 'ssh-copy-id' command."
echo "If you do not have this program you can install it with HOMEBREW or other package manager"
echo "Example with HOMEBREW => 'brew install ssh-copy-id'"
echo ""

#check for existance of ssh-copy-id
echo "Checking to see if your system has ssh-copy-id installed..."
command -v ssh-copy-id > /dev/null 2>&1
if [[ $? != 0 ]]; then
  echo "This script requires the 'ssh-copy-id' command."
  echo "If you do not have this program you can install it with HOMEBREW or other package manager"
  echo "Example with HOMEBREW => 'brew install ssh-copy-id'"
  exit 1
fi
#get remote system info
read -p "Enter remote IP address : " ip
read -p "Enter remote PORT to connect to : [press enter for port $dport] :" port
port=${port:-$dport}
read -p "Enter the username you wish to connect as : [press enter to use $duser] :" user
user=${user:-$duser}

#run ssh-copy-id command
ssh-copy-id -p $port $ip

#exit with same exit code as above command
exitCode=$?
exit $exitCode

