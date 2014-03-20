#!/bin/bash

echo "**************************"
echo "       SSH Pivot"
echo "**************************"
dport=22
duser=$(whoami)
read -p "Enter remote IP address : "  ip
read -p "Enter remote PORT to connect to (SSH PORT) : [press enter for port $dport] :" port
port=${port:-$dport}
read -p "Enter the username you wish to connect as : [press enter to use $duser] :"  user
user=${user:-$duser}
read -p "Enter the IP Address you would like to Pivot to once your connected through SSH : (ex. 192.168.1.10) : " pivot_ip
read -p "Enter the port you would like to connect to on the Pivot IP Address entered above : (ex. 5900 for VNC) : " remote_port
read -p "Enter the local port to bind to the remote port from above to : (ex. local_port:Pivot_IP:remote_port) : " local_port

echo "Attempting to SSH to $ip on port $port with username $user and Pivot to $pivot_ip on port $remote_port through local port $local_port (e.g. $local_port:$pivot_ip:$remote_port)"

ssh -p $port -N -L $local_port:$pivot_ip:$remote_port $user@$ip &
statusCode=$?
if [[ $statusCode -gt 0 ]]; then
  echo "Failed...exiting..."
  exit $statusCode
else
  echo "Success, ssh currently running in background..."
fi
