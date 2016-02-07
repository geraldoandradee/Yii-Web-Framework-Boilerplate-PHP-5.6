# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
    config.vm.box = "puphpet/centos65-x64"
    config.vm.box_url = "http://box.puphpet.com/centos-6.8-x86_64-20151130-virtualbox.box"

    config.vm.box_check_update = false
    config.vm.network "private_network", ip: "192.168.33.25"

    config.vm.synced_folder "./", "/www/yiiboilerplate.com"

    config.vm.provider "virtualbox" do |vb|
        vb.gui = false
        vb.memory = "1024"
    end

    config.vm.provision "shell" do |shell|
      shell.path = "manifests/setup.sh"
    end

    config.vm.provider "virtualbox"
end
