#!/bin/bash
# Copies files to the server and runs install.sh

# Usage: ./deploy.sh [host]
 
host="${1:-map7@192.168.200.161}"
 
# The host key might change when we instantiate a new VM, so
# we remove (-R) the old host key from known_hosts
ssh-keygen -R "${host#*@}" 2> /dev/null
 
tar cj . | ssh -o 'StrictHostKeyChecking no' "$host" '
sudo rm -rf ~/chef &&
mkdir ~/chef &&
cd ~/chef &&
tar xj &&
sudo bash install.sh'
