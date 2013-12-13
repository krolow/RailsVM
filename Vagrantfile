Vagrant.configure("2") do |config|
  config.vm.box = "wheezy64"
  config.vm.box_url = "http://puppet-vagrant-boxes.puppetlabs.com/debian-70rc1-x64-vbox4210.box"

  config.vm.network :private_network, ip: "192.168.56.199"
  config.ssh.forward_agent = true

  config.vm.provider :virtualbox do |v|
    v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    v.customize ["modifyvm", :id, "--memory", 1024]
    v.customize ["modifyvm", :id, "--name", "Rails VM"]
    v.customize ['modifyvm', :id, '--usb', 'on']
    v.customize ["modifyvm", :id, "--usbehci", "on"]
  end

  config.vm.synced_folder "../", "/home/vagrant/project", id: "vagrant-root", :mount_options => ["dmode=777","fmode=777"]
  config.vm.provision :shell, :inline =>
    "if [[ ! -f /apt-get-run ]]; then sudo apt-get update && sudo touch /apt-get-run; fi"

  config.vm.provision :puppet, :facter => { "osfamily" => "debian" }, :module_path => "modules" do |puppet|
    puppet.manifests_path = "manifests"
    puppet.module_path = "modules"
    #puppet.options = %w[ --libdir=\\$modulepath/rbenv/lib ]
  end
end
