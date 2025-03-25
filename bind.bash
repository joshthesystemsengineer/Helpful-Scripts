#!/bin/bash

# This script creates a lxc container in proxmox that houses bind9 and can be used for a dns server. 

#Notes:
#1) Your container image location may be different dependent on your proxmox config
#2) Feel free to add utils or any other goodies in the getting container ready section

cat <<EOF
 ___                    _  _       __      __
 | __ )(_)_ __   __| | |  _ \| \ | / ___|  / ___|  ___ _ ____   _____ _ __
 |  _ \| | '_ \ / _\` | | | | |  \| \___ \  \___ \ / _ \ '__\ \ / / _ \ '__|
 | |_) | | | | | (_| | | |_| | |\  |___) |  ___) |  __/ |   \ V /  __/ |
 |____/|_|_| |_|\__,_| |____/|_| \_|____/  |____/ \___|_|    \_/ \___|_|
EOF

echo "Welcome to Bind DNS Server Container"

echo "-----Customize container---------"

read -p "Enter a vmid: " vmid
read -p "Choose template image: " os
read -p "Enter a hostname: " hostname
read -p "Enter Memory (MiB): " memory
read -p "Enter CPU Core Count: " core
read -p "Enter a tag (optional): " tag
read -p "Enter an IP: " ip
read -p "Enater a Gateway: " gw
read -p "Enter a password: " password
echo ""

description="This is a light weight bind dns container that uses bind9."

pct create $vmid /var/lib/vz/template/cache/$os --cores $core --hostname $hostname --memory $memory --tags $tag --unprivileged 1 --password $password --description >

echo "-----Starting container----------"
pct start $vmid

sleep 5

echo "-----Getting container ready-----"
pct exec $vmid -- bash -c "apt update && apt install -y bind9 dnsutils vim"

echo "-----Done------------------------"





