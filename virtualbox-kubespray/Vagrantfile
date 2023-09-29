IMAGE_NAME = "centos/7"
MASTERS = 1
NODES = 3

Vagrant.configure("2") do |config|
    config.ssh.insert_key = false

    config.vm.provider "virtualbox" do |v|
        v.memory = 2048
        v.cpus = 1
    end

    (1..MASTERS).each do |i| 
        config.vm.define "master-#{i}" do |master|
            master.vm.box = IMAGE_NAME
            master.vm.network "private_network", ip: "192.168.57.#{i + 100}"
            master.vm.hostname = "master-#{i}"

            # naming the virtualmachine
            master.vm.provider :virtualbox do |vb|
                vb.name = "master-#{i}"
            end
            # change ansible to ansible_local if you are running from windows,
            # so that vagrant will install ansible inside VM and run ansible playbooks
            # eg: master.vm.provision "ansible_local" do |ansible|
            master.vm.provision "ansible_local" do |ansible|
                ansible.compatibility_mode = "2.0"
                ansible.playbook = "node-config.yml"
                ansible.extra_vars = {
                    node_ip: "192.168.50.#{i + 10}",
                }
            end
        end
    end

    (1..NODES).each do |i|
        config.vm.define "node-#{i}" do |node|
            node.vm.box = IMAGE_NAME
            node.vm.network "private_network", ip: "192.168.57.#{i + 110}"
            node.vm.hostname = "node-#{i}"

            # naming the virtualmachine
            node.vm.provider :virtualbox do |vb|
                vb.name = "node-#{i}"
            end
            
            # change ansible to ansible_local if you are running from windows,
            # so that vagrant will install ansible inside VM and run ansible playbooks
            # eg: node.vm.provision "ansible_local" do |ansible|
            node.vm.provision "ansible_local" do |ansible|
                ansible.compatibility_mode = "2.0"
                ansible.playbook = "node-config.yml"
                ansible.extra_vars = {
                    node_ip: "192.168.50.#{i + 20}",
                }
            end
        end
    end
end
