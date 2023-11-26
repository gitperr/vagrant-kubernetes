#!/bin/bash

su - vagrant -c "kubectl apply -f /vagrant/nginx-pod.yml"
su - vagrant -c "kubectl apply -f /vagrant/nginx-service.yml"
su - vagrant -c "kubectl apply -f /vagrant/nginx-public.yml"

su - vagrant -c "kubectl get pods,svc -o wide"