# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.provider "virtualbox" do |v|
	v.memory = 8096
	v.cpus = 4
  end

  config.vm.box = "ubuntu/trusty64"

  config.vm.network "forwarded_port", guest: 3000, host: 8950, auto_correct: true

  config.vm.synced_folder "VisualPython", "/var/VisualPython"

#  $script = <<SCRIPT
#cd /vagrant/share
#jupyter notebook --ip=0.0.0.0 --port=3000 --no-browser &
#SCRIPT

#  config.vm.provision "run_jupiter", type: "shell", run: "always", inline: $script
#"cd /vagrant/share && jupyter notebook --ip=0.0.0.0 --port=3000 --no-browser "
end

