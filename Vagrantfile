Vagrant.configure("2") do |config|
    #Master Server
    config.vm.synced_folder '.', '/vagrant', disabled: true
    config.vm.define "mmounchi" do |mmounchi|
      mmounchi.vm.box = "centos/8"
      mmounchi.vm.hostname = "Master"
      mmounchi.vm.box_url = "centos/8"
      mmounchi.vm.network :private_network, ip: "192.168.42.110"
      mmounchi.vm.provider :virtualbox do |v|
        v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
        v.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
        v.customize ["modifyvm", :id, "--memory", 1024]
        v.customize ["modifyvm", :id, "--name", "Misaki Master"]
        v.customize ["modifyvm", :id, "--cpus", "1"]
      end
      config.vm.provision "shell", inline: <<-SHELL
      sed -i 's/ChallengeResponseAuthentication no/ChallengeResponseAuthentication yes/g' /etc/ssh/sshd_config
      systemctl restart sshd
      SHELL
      mmounchi.vm.provision "shell", path: "install_master.sh" , run: "always"
      config.trigger.after :up do |trigger|
        trigger.run = {inline: 
          'bash -c "vagrant ssh -c \"sudo cat /var/lib/rancher/k3s/server/node-token\" mmounchi > test.txt"'}
      end
    end
    #Slave Server
    config.vm.define "slave" do |slave|
      slave.vm.box = "centos/8"
      slave.vm.hostname = "ServerWorker"
      slave.vm.network "private_network", ip: "192.168.42.111"
      slave.vm.provider "virtualbox" do |v|
        v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
        v.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
        v.customize ["modifyvm", :id, "--memory", 1024]
        v.customize ["modifyvm", :id, "--name", "Misaki Slave"]
        v.customize ["modifyvm", :id, "--cpus", "1"]
      end
      config.vm.provision "shell", inline: <<-SHELL
      sed -i 's/ChallengeResponseAuthentication no/ChallengeResponseAuthentication yes/g' /etc/ssh/sshd_config
      systemctl restart sshd
      SHELL
      config.vm.provision "file", source: "~/test.txt", destination: "token.txt" , run: "always"
      slave.vm.provision "shell", path: "install_worker.sh", run: "always"
  end
end