# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure(2) do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://atlas.hashicorp.com/search.
  config.vm.box = 'centos/7'
  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  config.vm.network "forwarded_port", guest: 80, host: 8084
  config.vm.network "forwarded_port", guest: 443, host: 8443
  config.vm.network 'forwarded_port', guest: 8080, host: 8085, protocol: 'tcp'
  config.vm.hostname = 'devops001.vagrant.vm'
  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network "private_network", ip: "192.168.33.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"
  config.vm.synced_folder "../", "/vagrant"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  # config.vm.provider "virtualbox" do |vb|
  #   # Display the VirtualBox GUI when booting the machine
  #   vb.gui = true
  #
  #   # Customize the amount of memory on the VM:
  #   vb.memory = "1024"
  # end
  #
  # View the documentation for the provider you are using for more
  # information on available options.

  # Define a Vagrant Push strategy for pushing to Atlas. Other push strategies
  # such as FTP and Heroku are also available. See the documentation at
  # https://docs.vagrantup.com/v2/push/atlas.html for more information.
  # config.push.define "atlas" do |push|
  #   push.app = "YOUR_ATLAS_USERNAME/YOUR_APPLICATION_NAME"
  # end

  # Enable provisioning with a shell script. Additional provisioners such as
  # Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
  # documentation for more information about their specific syntax and use.
  #FACTER_applicaiton_service_account=belkdeploy

  config.vm.provision 'shell', inline: <<-SHELL
        # update Puppet
        rpm --import https://yum.puppetlabs.com/RPM-GPG-KEY-puppet     
        rpm -Uvh https://yum.puppetlabs.com/puppetlabs-release-pc1-el-7.noarch.rpm
        yum -y -q install puppet-agent 
        source /etc/profile
        # end update puppet
        puppet module install puppet-nginx --version 0.9.0        
        puppet module install puppetlabs-tomcat --version 2.2.0
        puppet module install puppetlabs-java --version 2.4.0
        puppet module install puppet-kafka --version 5.0.0
        puppet module install crayfishx-firewalld --version 3.4.0  
        puppet module install puppet-selinux --version 1.5.2
        #puppet module install puppet-alternatives --version 2.0.0    
        cp -r /vagrant/demo_kafka  /etc/puppetlabs/code/environments/production/modules
        puppet apply /etc/puppetlabs/code/environments/production/modules/demo_kafka/examples/init.pp
  SHELL

end
