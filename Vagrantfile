VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
    config.vm.box = "ubuntu/xenial64"
    config.vm.synced_folder ".", "/opt/khk-web"
    config.ssh.forward_agent = true
    config.vm.network "forwarded_port", guest: 80, host: 80
    config.vm.provision "shell", path: "vm/provision.sh"
end
