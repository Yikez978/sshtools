#!/bin/bash

echo "**************************"
echo "    Coffee Shop Proxy"
echo "**************************"
dport=22
duser=$(whoami)
dmonport=20000
dproxyport=5000
echo "Checking if AUTOSSH is currently running..."
autosshPID=$(ps -A | grep 'autossh' | grep -v grep | awk '{print $1}')
if [ -n "$autosshPID" ]; then
	echo "AUTOSSH PID is : $autosshPID"
	echo "Killing AUTOSSH..."
	kill -9 $autosshPID
else
	echo "AUTOSSH is not running."
fi
read -p "Enter remote IP address : "  ip
read -p "Enter remote PORT to connect to : [press enter for port $dport] :" port
port=${port:-$dport}
read -p "Enter the username you wish to connect as : [press enter to use $duser] :"  user
user=${user:-$duser}
read -p "Enter the Monitor Port you would like AUTOSSH to use : [press enter to use $dmonport] : " monport
monport=${monport:-$dmonport}
read -p "Enter the Port you would like to your Proxy to listen on : [press enter to use $dproxyport] : " proxyport
proxyport=${proxyport:-$dproxyport}
echo "Attempting to autossh to $ip on port $port with as username $user with vvv verbosity:)..."
autossh -M $monport -D $proxyport $user@$ip -p $port -vvv
