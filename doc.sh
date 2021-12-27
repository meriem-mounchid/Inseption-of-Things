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
#test: k3d version
sudo k3d cluster create my-cluster --port 8080:80@loadbalancer --port 8443:443@loadbalancer --port 8888:81@loadbalancer --k3s-arg "--disable=traefik@server:0" 
# sudo k3d cluster delete demo-cluster
#test: kubectl cluster-info


### Argo CD CLI ###
sudo curl -sSL -o /usr/local/bin/argocd https://github.com/argoproj/argo-cd/releases/latest/download/argocd-linux-amd64
sudo chmod +x /usr/local/bin/argocd


### ArgoCD ###
sudo kubectl create namespace argocd
sudo kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
sudo kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "LoadBalancer"}}'

#LOG IN
sudo kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo
argocd login <ARGOCD_SERVER>
#

# sudo kubectl delete ns dev

sudo kubectl apply -f application.yaml
# sudo kubectl get ns
# sudo kubectl get pods -n dev
# sudo kubectl get svc -A
# sudo kubectl get ep -A
# sudo kubectl get deploy -A
# sudo kubectl get rs -A

# sudo docker pull wil42/playground:v1
# sudo docker image history wil42/playground:v1