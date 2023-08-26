# -*- mode: ruby -*-
# vi: set ft=ruby :
#

Vagrant.configure("2") do |config|
    config.vm.box =  "debian/bullseye64"
    config.vm.hostname = "debian-bullseye"
    config.vm.network :public_network, ip: "192.168.1.200", bridge: "wlp3s0"

    config.vm.synced_folder ".", "/vagrant"
    config.vm.synced_folder "/srv/packages/deb", "/vagrant/packages"

    config.ssh.forward_agent = true

    config.vm.provider "virtualbox" do |vb|
        vb.cpus = 4
        vb.gui = false
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

    config.vm.provision :ansible_local do |ansible|
        ansible.become = true
        ansible.groups = {
            "kilgoretrout" => ["default"]
        }

        ansible.compatibility_mode = "2.0"
        ansible.playbook = "playbook.yml"
        ansible.version = "latest"
        ansible.extra_vars = {
            ansible_python_interpreter: "/usr/bin/python3"
        }
        ansible.galaxy_roles_path = nil
        ansible.galaxy_role_file = "requirements.yml"
        ansible.galaxy_command = "ansible-galaxy install --role-file=%{role_file} --roles-path=%{roles_path}"
    end
end

