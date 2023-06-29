# -*- mode: ruby -*-
# vi: set ft=ruby :
#

Vagrant.configure("2") do |config|
    config.vm.box =  "debian/bullseye64"
    config.vm.hostname = "debian-bullseye"
    config.vm.network :public_network, ip: "192.168.1.200", bridge: "wlp3s0"

    config.vm.provider "virtualbox" do |vb|
        vb.memory = 8192
        vb.name = "reprepro"
    end

    config.vm.provision :shell do |s|
        s.path = "scripts/root.sh"
        s.env = {
            PORT: ENV["PORT"],
            REPO_DIR: ENV["REPO_DIR"],
        }
    end
end

