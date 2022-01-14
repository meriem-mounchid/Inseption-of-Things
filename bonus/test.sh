sudo apt update
sudo apt -y upgrade 
sudo apt -y install curl vim openssh-server ca-certificates
curl https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.deb.sh | sudo bash
sudo apt install gitlab-ce

#sudo vi /etc/gitlab/gitlab.rb
sudo gitlab-ctl reconfigure
sudo cat /etc/gitlab/initial_root_password
# MOW+282OROUUxS0ny0+Ptrn3AYaMETWigEXU5BZdxHQ=
# repoURL: https://github.com/meriem-mounchid/argocd-app.git
# git clone http://10.12.100.144/root/gitlabbonus.git


sudo kubectl config view --raw -o=jsonpath='{.clusters[0].cluster.certificate-authority-data}' | base64 --decode
vim rbac-git.yaml
vim rbac-gitlab.yaml
sudo kubectl cluster-info | grep -E 'Kubernetes master|Kubernetes control plane' | awk '/http/ {print $NF}'
sudo kubectl cluster-info| grep master
SECRET=$(sudo kubectl -n kube-system get secret | grep gitlab | awk '{print $1}')
echo $SECRET
sudo kubectl apply -f rbac-git.yaml -n kube-system
sudo kubectl -n kube-system get secret $SECRET -o jsonpath='{.data.token}' | base64 --decode && echo


curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh

helm repo add gitlab https://charts.gitlab.io
