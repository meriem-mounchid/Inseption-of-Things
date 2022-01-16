# ------- Install GitLab -------
sudo apt update
sudo apt -y upgrade 
sudo apt -y install curl vim openssh-server ca-certificates
curl https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.deb.sh | sudo bash
sudo apt install gitlab-ce
# ------- Creer un Projet -------
# ------- Installer un Cluster -------
# ------- Recuperation du Certificat -------


#sudo vi /etc/gitlab/gitlab.rb
sudo gitlab-ctl reconfigure
sudo cat /etc/gitlab/initial_root_password
# MOW+282OROUUxS0ny0+Ptrn3AYaMETWigEXU5BZdxHQ=
# repoURL: https://github.com/meriem-mounchid/argocd-app.git
# git clone http://10.12.100.144/root/gitlabbonus.git

sudo kubectl config view --raw -o=jsonpath='{.clusters[0].cluster.certificate-authority-data}' | base64 --decode

vim rbac-git.yaml
apiVersion: v1
kind: ServiceAccount
metadata:
  name: gitlab
  namespace: kube-system
---
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: gitlab-admin
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: cluster-admin
subjects:
  - kind: ServiceAccount
    name: gitlab
    namespace: kube-system

sudo kubectl apply -f rbac-git.yaml
# vim rbac-gitlab.yaml
sudo kubectl cluster-info | grep -E 'Kubernetes master|Kubernetes control plane' | awk '/http/ {print $NF}'
sudo kubectl cluster-info| grep master
SECRET=$(sudo kubectl -n kube-system get secret | grep gitlab | awk '{print $1}')
echo $SECRET
TOKEN=$(sudo kubectl -n kube-system get secret $SECRET -o jsonpath='{.data.token}' | base64 --decode)

sudo kubectl apply -f rbac-git.yaml -n kube-system
sudo kubectl -n kube-system get secret $SECRET -o jsonpath='{.data.token}' | base64 --decode && echo

curl https://baltocdn.com/helm/signing.asc | sudo apt-key add -
sudo apt-get install apt-transport-https --yes
echo "deb https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list
sudo apt-get update
sudo apt-get install helm

sudo kubectl create namespace gitlab
#Installing GitLab Runner using the Helm Chart
sudo helm repo add gitlab https://charts.gitlab.io

sudo helm install --namespace gitlab gitlab-runner -f values.yaml gitlab/gitlab-runner
