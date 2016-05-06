#!/bin/bash

if [ "$EUID" -eq 0 ]; then
    echo "Do not run it as root as it will break attributes"
    exit
fi

sed -i "s/CHANGEME/$(whoami)/" solo.json

if ! dpkg -l chefdk; then
    curl -L https://packages.chef.io/stable/ubuntu/12.04/chefdk_0.12.0-1_amd64.deb -o /tmp/chefdk_0.12.0-1_amd64.deb
    sudo dpkg -i /tmp/chefdk_0.12.0-1_amd64.deb
fi

sudo /usr/bin/chef-solo -c solo.rb -j solo.json

echo "NOW REBOOT"
