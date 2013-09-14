#!/bin/bash

echo "**************************"
echo "       SSH to VNC"
echo "**************************"
dport=5140
duser=$(whoami)
read -p "Enter remote IP address :"  ip
echo "You have entered $ip"
read -p "Enter remote PORT to connect to : [press enter for port $dport] :" port
port=${port:-$dport}
echo "You have entered $port"
read -p "Enter the username you wish to connect as : [press enter to use $duser] :"  user
user=${user:-$duser}
echo "Attempting to ssh to $ip on port $port with as username $user"
ssh -p $port $user@$ip
exit 0
