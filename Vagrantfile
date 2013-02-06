# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant::Config.run do |config|
  config.vm.box = "lucid32"
  # config.vm.box_url = "http://domain.com/path/to/above.box"

  config.vm.define :level2 do |level2_config|
    level2_config.vm.network :hostonly, "192.168.33.102"

    level2_config.vm.provision :puppet do |puppet|
       puppet.manifests_path = "puppet/manifests"
       puppet.manifest_file  = "level02.pp"
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
