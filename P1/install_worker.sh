### Worker ###
k3s_url="https://192.168.42.110:6443"
k3s_token=$(cat token.txt)
echo $k3s_token
curl -sfL https://get.k3s.io | K3S_TOKEN=${k3s_token} K3S_URL=${k3s_url} K3S_KUBECONFIG_MODE="644" sh -

sudo sed -i '$ d' /etc/systemd/system/k3s-agent.service
echo -e "\t--flannel-iface 'eth1'" | sudo tee -a /etc/systemd/system/k3s-agent.service

sudo systemctl daemon-reload
sudo systemctl restart k3s-agent
#sudo systemctl restart k3s-agent.service
