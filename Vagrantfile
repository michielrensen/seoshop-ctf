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
  config.vm.box_url = "https://www.dropbox.com/s/kpk5gett03vu8au/stripe-ctf-base-v3.box"

  config.vm.define :level2 do |box_config|
    configure(box_config, "2")
  end
  config.vm.define :level5 do |box_config|
    configure(box_config, "5")
  end
  config.vm.define :level6 do |box_config|
    configure(box_config, "6")
  end
  config.vm.define :level8 do |box_config|
    configure(box_config, "8")
  end
end
