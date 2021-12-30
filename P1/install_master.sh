#!/bin/bash
### Master ###

sudo -s
curl -sfL https://get.k3s.io | sh -s - --write-kubeconfig-mode 644

sed -i '$ d' /etc/systemd/system/k3s.service
echo -e "\t--flannel-iface 'eth1'" | tee -a /etc/systemd/system/k3s.service
systemctl daemon-reload
systemctl restart k3s

cat <<EOF > /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOF

yum install -y kubectl

#test: kubectl get node -o wide
#TOKEN: cat /var/lib/rancher/k3s/server/node-token
##test: service k3s status