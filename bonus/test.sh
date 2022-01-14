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