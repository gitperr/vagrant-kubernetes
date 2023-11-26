# Vagrant-Kubernetes
Uses Vagrant for deploying Kubernetes cluster with Oracle VirtualBox.

Original code is in https://github.com/mohitkr05/vagrant, this repo includes my fixes  
because some of the original code did not work for me properly.

## Running
1. Clone the repo  
2. `cd vagrant-kubernetes && vagrant up`  

## Destroy the VMs once done
1. `cd vagrant-kubernetes && vagrant destroy`

## Known issues
1. Worker node cannot join the cluster because of the network interface not coming up quickly. There is a dirty fix for this:  
you can ssh into the master node `vagrant ssh master` and ping the problematic host `ping worker1.example.com`. Then, it magically comes up for some reason.