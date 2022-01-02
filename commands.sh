#!/bin/bash

### LOG IN (ArgoCD) ### 
# sudo kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo
# argocd login <ARGOCD_SERVER>

# sudo kubectl delete ns dev
# sudo kubectl get ns
# sudo kubectl get pods -n dev
# sudo kubectl get svc -A
# sudo kubectl get ep -A
# sudo kubectl get deploy -A
# sudo kubectl get rs -A

### Move ur file on ur host to ur vm ###
# scp script.sh application.yaml misaki@10.12.100.165:~

### See wil42 port ###
# sudo docker pull wil42/playground:v1
# sudo docker image history wil42/playground:v1
