#IMAGE_NAME = "centos/8"
IMAGE_NAME = "fedora/35-cloud-base"

ANSIBLE_NODES = 2

## only needed if you are using ansible engine vm with bridged network
#ANSILBE_ENGINE_IP = "192.168.1.185"

Vagrant.configure("2") do |config|
    config.ssh.insert_key = false

    (1..ANSIBLE_NODES).each do |i|
        config.vm.define "ansible-node-#{i}" do |node|
            node.vm.box = IMAGE_NAME
            node.vm.network "private_network", ip: "192.168.50.#{i + 20}", virtualbox__intnet: "intnet"
            node.vm.hostname = "ansible-node-#{i}"

            # naming the virtualmachine
            node.vm.provider :virtualbox do |vb|
                vb.name = "ansible-node-#{i}"
                vb.memory = 1024
                vb.cpus = 1
            end
            
            # execute nodes-sshd.sh for configuring ssh.
            node.vm.provision :shell, path: "files/nodes-sshd.sh"

            #node.vm.provision "ansible" do |ansible|
            #    ansible.compatibility_mode = "2.0"
            #    ansible.playbook = "ansible-node-config.yml"
            #    ansible.extra_vars = {
            #        node_ip: "192.168.50.#{i + 20}",
            #    }
            #end
        end
    end

    config.vm.define "ansible-engine" do |ansible|
        ansible.vm.box = IMAGE_NAME
        ansible.vm.network "private_network", ip: "192.168.50.11", virtualbox__intnet: "intnet"

        ## Below interface has been disables as different machines will have different bridge interface.
        ## You can enable this back and use for additional bridged interface on ansible engine node.
        ## Choose options 1, 2 or 3 when it prompts, depends on the actual network interface on your laptop/workstation.
        #ansible.vm.network "public_network", ip: ANSILBE_ENGINE_IP
        
        
        ansible.vm.hostname = "ansible-engine1"

        # naming the virtualmachine
        ansible.vm.provider :virtualbox do |vb|
            vb.name = "ansible-engine1"
            vb.memory = 2048
            vb.cpus = 1
        end

        # execute nodes-sshd.sh for configuring ssh.
        ansible.vm.provision :shell, path: "files/nodes-sshd.sh"
        
        # 1. Expecting the project directory conte available at /vagrant.
        # 2. Using ansible_local to avoid any additional ansible requirement on
        #    host machine (eg: Windows). Vagrant will install ansible on target machine
        #    and complete the initial configuration.
        ansible.vm.provision "ansible_local" do |ansible|
            ansible.compatibility_mode = "2.0"
            ansible.playbook = "/vagrant/files/engine-config.yaml"
            ansible.extra_vars = {
                node_ip: "192.168.50.11",
            }
        end
        
        # execute nodes-init.yaml for configuring other ansible nodes.
        ## disabled for engine only setup
        ## ansible.vm.provision :shell, path: "files/nodes-init-playbook.sh"
    end
        
end
