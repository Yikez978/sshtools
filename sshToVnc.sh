#!/bin/bash

echo "**************************"
echo "       SSH to VNC"
echo "**************************"
dip=192.168.1.35
dport=5140
duser=$(whoami)
read -p "Enter remote IP address : [press enter for $dip] : "  ip
ip=${ip:-$dip}
echo "You have entered $ip"
read -p "Enter remote PORT to connect to : [press enter for port $dport] :" port
port=${port:-$dport}
echo "You have entered $port"
read -p "Enter the username you wish to connect as : [press enter to use $duser] :"  user
user=${user:-$duser}
echo "Attempting to ssh to $ip on port $port with as username $user"
ssh -p $port -N -L 5905:127.0.0.1:5900 $user@$ip &
sleep 1
open vnc://127.0.0.1:5905
sleep 2
screenPID=$(ps -A | grep 'Screen Sharing' | grep -v grep | awk '{print $1}')
sshPID=$(lsof | grep "5905" | grep -v IPv6 | awk '{print $2}')
echo "The Screen Sharing PID is : $screenPID"
kill -0 $screenPID >/dev/null 2>&1
result=$?
while [ $result -ne 1 ]; do
    sleep 1
    kill -0 $screenPID >/dev/null 2>&1
    result=$?
done
echo "Now is the time to kill to process?"
kill $sshPID
exitCode=$?
echo "Exit Code : $exitCode"
exit $exitCode
