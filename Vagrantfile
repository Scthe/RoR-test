# -*- mode: ruby -*-
# vi: set ft=ruby :

# REQUIREMENTS:
# librarian-chef install # in /chef to download all cookbooks
# vagrant plugin install vagrant-omnibus # to force chef version

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  
  config.vm.box = "hashicorp/precise64"
  config.vm.box_check_update = false

  config.vm.network :forwarded_port, guest: 3000, host: 3001

  config.vm.provision :shell, :inline => "apt-get install curl -y"

  # install new chef version
  config.omnibus.chef_version = "11.4.0" # :latest
  # chef provisioning
  config.vm.provision "chef_solo" do |chef|
    chef.cookbooks_path = ["chef/cookbooks", "chef/site-cookbooks"]

    chef.add_recipe "apt"
    chef.add_recipe "openssl"
    chef.add_recipe "ruby_build"
    chef.add_recipe "rbenv::user"
    chef.add_recipe "rbenv::system"
    chef.add_recipe "rbenv::vagrant"
    chef.add_recipe "nodejs"

    chef.json = {
      rbenv: {
        user_installs: [{
          user: 'vagrant',
          rubies: ["2.1.2"],
          global: "2.1.2",
          gems: { "2.1.2" => [{ name: "bundler" }] }
        }]
      }
    }
  end

  config.vm.provision :shell, :inline => "sudo apt-get install ruby-rspec -y"
  # config.vm.provision :shell, :inline => "sudo gem update rspec-rails -y"

end
