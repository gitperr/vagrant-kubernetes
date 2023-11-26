#!/bin/bash

HOST="master.example.com"
COUNT=5
IFACE="enp0s8"
# Restart the interface and sleep a bit, so it starts cleanly
sudo ip link set $IFACE down
sudo ip link set $IFACE up
sleep 30
# Ping the host for the specified count
for ((i=1; i<=$COUNT; i++))
do
  ping -c 1 $HOST -I $IFACE
done

sudo bash /vagrant/join-worker.sh
sleep 5
# containerd and docker need to be restarted after joining
# for clean initialization of CNI plugin
sudo systemctl restart containerd
sudo systemctl restart docker