# -*- mode: ruby -*-
# vi: set ft=ruby :

# Helper method to do all common Vagrant config for a given level number
def configure(vm_config, number)
  vm_config.vm.network :hostonly, "192.168.33.10#{number}"
  vm_config.vm.host_name = "level0#{number}-1.stripe-ctf.com"
  
  vm_config.vm.provision :puppet do |puppet|
     puppet.manifests_path = "puppet"
     puppet.module_path = "puppet/modules"
     puppet.manifest_file  = "site.pp"
  end
end

Vagrant::Config.run do |config|
  config.vm.box = "stripe-ctf-base"
  config.vm.box_url = "https://dl.dropbox.com/s/jbkevez3gvay7ue/stripe-ctf-base-v4.box?&dl=1"


  [*0..8].each do |number|

    config.vm.define "level#{number}".to_sym do |box_config|
      configure(box_config, number)
    end
  end
end
