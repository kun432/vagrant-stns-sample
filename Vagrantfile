# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vagrant.plugins = ["vagrant-vbguest", "vagrant-hostsupdater", "vagrant-hostmanager"]
  config.hostmanager.enabled = true
  config.hostmanager.manage_guest = true

  config.vm.define "stns-server" do |c|
      c.vm.box = "centos/7"
      c.vm.hostname = "stns-server.example.internal"
      c.vm.network "private_network", ip: "10.240.0.100"
      c.vm.provider "virtualbox" do |v|
        v.gui = false
        v.cpus = 1
        v.memory = 1024
      end
      c.vm.provision :shell, :path => "script/setup-init.sh"
      c.vm.provision :shell, :path => "script/setup-stns-base.sh"
      c.vm.provision :shell, :path => "script/setup-stns-server.sh"
      c.vm.provision :shell, :path => "script/setup-stns-client.sh"
  end
  
  config.vm.define "stns-client" do |c|
      c.vm.box = "centos/7"
      c.vm.hostname = "stns-client.example.internal"
      c.vm.network "private_network", ip: "10.240.0.101"
      c.vm.provider "virtualbox" do |v|
        v.gui = false
        v.cpus = 1
        v.memory = 1024
      end
      c.vm.provision :shell, :path => "script/setup-init.sh"
      c.vm.provision :shell, :path => "script/setup-stns-base.sh"
      c.vm.provision :shell, :path => "script/setup-stns-client.sh"
  end
end
