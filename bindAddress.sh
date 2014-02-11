#!/bin/bash

echo "**************************"
echo "   Bind to Remote Port"
echo "**************************"
dport=22
duser=$(whoami)
read -p "Enter remote IP address : "  ip
read -p "Enter remote PORT to connect to (SSH PORT) : [press enter for port $dport] :" port
port=${port:-$dport}
read -p "Enter the username you wish to connect as : [press enter to use $duser] :"  user
user=${user:-$duser}
read -p "Enter the remote port you would like to bind to : (ex. 5900 for VNC) : " remote_port
read -p "Enter the local port to bind to the remote port from above to : (ex. local_port:host:remote_port) : " local_port

echo "Attempting to ssh to $ip on port $port with as username $user and bind addresses $local_port:127.0.0.1:$remote_port"

ssh -p $port -N -L $local_port:127.0.0.1:$remote_port $user@$ip &
statusCode=$?
if [[ $statusCode -gt 0 ]]; then
  echo "Failed...exiting..."
  exit $statusCode
else
  echo "Success, ssh currently running in background..."
fi
