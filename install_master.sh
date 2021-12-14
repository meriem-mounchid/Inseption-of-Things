### Master ###
sudo su
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
curl -sfL https://get.k3s.io/ | K3S_KUBECONFIG_MODE="644" sh -

mkdir /root/.kube
cp /etc/rancher/k3s/k3s.yaml /root/.kube/config

#vi /etc/systemd/system/k3s-agent.service
#--flannel-iface 'eth1'
sudo sed -i '$ d' /etc/systemd/system/k3s.service
echo -e "\t--flannel-iface 'eth1'" | sudo tee -a /etc/systemd/system/k3s.service

systemctl daemon-reload
systemctl restart k3s.service
#test: kubectl get node -o wide
#TOKEN: sudo cat /var/lib/rancher/k3s/server/node-token