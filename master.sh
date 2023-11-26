#!/bin/bash


kubeadm config images pull

sudo kubeadm init --pod-network-cidr=10.244.0.0/16 --control-plane-endpoint=master.example.com --apiserver-advertise-address=192.168.56.100

sleep 10
# Configure kubeconfig for the master
mkdir -p /home/vagrant/.kube
sudo cp -i /etc/kubernetes/admin.conf /home/vagrant/.kube/config
sudo chown vagrant:vagrant /home/vagrant/.kube/config

sudo ufw allow 6443
# kube-flannel.yml has the same contents as the definition in https://github.com/flannel-io/flannel/tree/master#deploying-flannel-with-kubectl
# remember to run the command as vagrant user, so it finds the kubernetes cluster properly
su - vagrant -c "kubectl apply -f /vagrant/kube-flannel.yml"

sudo systemctl daemon-reload
sudo systemctl restart kubelet
sudo systemctl enable kubelet
sudo systemctl restart containerd
sudo systemctl restart docker

sleep 10

su - vagrant -c "kubectl get pods -A"


sudo kubeadm token create --print-join-command > /vagrant/join-worker.sh
chmod +x /vagrant/join-worker.sh
