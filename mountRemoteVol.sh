#!/bin/bash

echo "**************************"
echo "   Mount Remote Volume"
echo "**************************"
read -p "Enter a name for the remote volume you wish to mount : " remote_name

dport=22
duser=$(whoami)
dremote_dir=/
dlocal_mount_dir=~/mount/$remote_name

read -p "Enter remote IP address : "  ip

read -p "Enter remote PORT to connect to (SSH PORT) : [press enter for port $dport] :" port
port=${port:-$dport}

read -p "Enter the username you wish to connect as : [press enter to use $duser] :"  user
user=${user:-$duser}

read -p "Enter the remote directory you would like to mount : [press enter for $dremote_dir] : " remote_dir
remote_dir=${remote_dir:-$dremote_dir}

read -p "Enter the local directory you would like to mount remote file system : [press enter for $dlocal_mount_dir] : " local_mount_dir
local_mount_dir=${local_mount_dir:-$dlocal_mount_dir}

if [[ -d $local_mount_dir && ! -L $local_mount_dir ]]; then
  echo "$local_mount_dir already exists, proceeding to mount..."
else
  echo "$local_mount_dir doesn't exist yet...making directory and then proceeding to mount..."
  mkdir -pv $local_mount_dir
fi

echo "Attempting to ssh to $ip on port $port with as username $user and mount $remote_dir to local mount dir $local_mount_dir"

sshfs -p $port $user@$ip:$remote_dir $local_mount_dir -oauto_cache,reconnect,defer_permissions,noappledouble,negative_vncache,volname=$remote_name
exit $?

