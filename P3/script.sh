#!/bin/bash

### Docker on Ubuntu ###
curl -fsSL https://test.docker.com -o test-docker.sh
sudo sh test-docker.sh
sudo systemctl start docker
sudo systemctl enable docker
#test: systemctl status docker


### Install kubectl on Ubuntu ###
curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.18.0/bin/linux/amd64/kubectl
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl
#test: kubectl version --client


### install K3D ###
curl -s https://raw.githubusercontent.com/rancher/k3d/main/install.sh | bash
sudo k3d cluster create my-cluster --port 8080:80@loadbalancer --port 8443:443@loadbalancer --port 8888:81@loadbalancer --k3s-arg "--disable=traefik@server:0" 
#test: k3d version
#test: kubectl cluster-info


### Argo CD CLI ###
sudo curl -sSL -o /usr/local/bin/argocd https://github.com/argoproj/argo-cd/releases/latest/download/argocd-linux-amd64
sudo chmod +x /usr/local/bin/argocd


### ArgoCD ###
sudo kubectl create namespace argocd
sudo kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
sudo kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "LoadBalancer"}}'
