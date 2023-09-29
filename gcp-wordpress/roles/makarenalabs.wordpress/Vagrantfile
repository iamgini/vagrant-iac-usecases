VAGRANTFILE_API_VERSION = "2"
Vagrant.require_version ">= 1.6.5"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "ubuntu/bionic64"
  config.vm.hostname = 'test'

  config.vm.network :private_network, ip: "192.168.33.11"
  config.vm.network :forwarded_port, guest: 22, host: 2210, id: "ssh"

  config.vm.provision "ansible" do |ansible|
    ansible.playbook = "tests/test.yml"
    ansible.verbose = 'vv'
    ansible.become = true
  end
end
