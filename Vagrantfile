# -*- mode: ruby -*-
# vi: set ft=ruby :

# Helper method to do all common Vagrant config for a given level number
def configure(vm_config, number)
  vm_config.vm.network "public_network", ip: "192.168.1.10#{number}", bridge: "en0: Wi-Fi (AirPort)"
  vm_config.vm.host_name = "level0#{number}.seoshop.net"
  
  vm_config.vm.provision :puppet do |puppet|
     puppet.manifests_path = "puppet"
     puppet.module_path = "puppet/modules"
     puppet.manifest_file  = "site.pp"
  end
end

Vagrant.configure("2") do |config|
  config.vm.box = "stripe-ctf-base"
  config.vm.box_url = "https://dl.dropbox.com/s/jbkevez3gvay7ue/stripe-ctf-base-v4.box?&dl=1"


  [*0..8].each do |number|

    config.vm.define "level#{number}".to_sym do |box_config|
      configure(box_config, number)
    end
  end
end
