### Worker ###
k3s_url="https://192.168.42.110:6443"
k3s_token=$(cat token.txt)
sudo -s
curl -sfL https://get.k3s.io | K3S_TOKEN=${k3s_token} K3S_URL=${k3s_url} K3S_KUBECONFIG_MODE="644" sh -
sed -i '$ d' /etc/systemd/system/k3s-agent.service
echo -e "\t--flannel-iface 'eth1'" | tee -a /etc/systemd/system/k3s-agent.service

systemctl daemon-reload
systemctl restart k3s-agent
#test: sudo service k3s-agent status