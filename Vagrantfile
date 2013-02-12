# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant::Config.run do |config|
  config.vm.box = "stripe-ctf-base"
  config.vm.box_url = "https://www.dropbox.com/s/qhdb95prfjqh2r9/stripe-ctf-base-v2.box"

  config.vm.define :level2 do |level2_config|
    level2_config.vm.network :hostonly, "192.168.33.102"
    level2_config.vm.host_name = "level02-1.stripe-ctf.com"

    level2_config.vm.provision :puppet do |puppet|
       puppet.manifests_path = "puppet"
       puppet.module_path = "puppet/modules"
       puppet.manifest_file  = "site.pp"
    end
  end

  config.vm.define :level5 do |level5_config|
    level5_config.vm.network :hostonly, "192.168.33.105"

    level5_config.vm.provision :puppet do |puppet|
       puppet.manifests_path = "puppet/manifests"
       puppet.manifest_file  = "level05.pp"
    end
  end
end
