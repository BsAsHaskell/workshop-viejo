# -*- coding: utf-8 -*-
# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.provider "virtualbox" do |v|
    v.memory = 1024
    v.cpus = 2
  end

  config.vm.define "haskell-dev", autostart: true do |machine|
      machine.vm.box = "ubuntu/trusty64"
      machine.vm.hostname = "haskell-dev"
      machine.vm.network "private_network", ip: "192.168.50.10"
  end
end
