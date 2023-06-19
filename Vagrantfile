Vagrant.configure("2") do |config|
  config.hostmanager.enabled = true 
  config.hostmanager.manage_host = true
  config.vm.define "centOS" do |centOS|
    centOS.vm.box = "geerlingguy/centos7"
    # config.vm.box_check_update = false
    # config.vm.network "forwarded_port", guest: 80, host: 8080
    # config.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"
    centOS.vm.hostname = "centos"
    centOS.disksize.size = '25GB'
    centOS.vm.network "private_network", ip: "192.168.22.10"
    centOS.vm.network "public_network"
    centOS.vm.synced_folder ".", "/vagrant_data"
    centOS.vm.provider "virtualbox" do |vb|
      # vb.gui = true
      vb.memory = "2048"
      vb.cpus = 2
    end
    centOS.vm.provision "shell", path: "provision/centOS.sh"
  end

  config.vm.define "ubuntu" do |ubuntu|
    ubuntu.vm.box = "ubuntu/bionic64"
    # config.vm.box_check_update = false
    ubuntu.vm.hostname = "ubuntu"
    ubuntu.disksize.size = '25GB'
    ubuntu.vm.network "forwarded_port", guest: 5432, host: 5555
    # config.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"
    ubuntu.vm.network "private_network", ip: "192.168.22.11"
    ubuntu.vm.network "public_network"
    ubuntu.vm.synced_folder ".", "/vagrant_data"
    ubuntu.vm.provider "virtualbox" do |vb|
      # vb.gui = true
      vb.memory = "2048"
      vb.cpus = 2
    end
    ubuntu.vm.provision "shell", path: "provision/ubuntu.sh"
  end
  
end
