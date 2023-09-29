sudo sed -i "s/PasswordAuthentication no/PasswordAuthentication yes/g" /etc/ssh/sshd_config
sudo systemctl restart sshd

sudo python3 -m pip install pip --upgrade
#sudo su - devops && python3 -m pip install ansible --user

# install git and vim
sudo yum install -y vim git

# add devops user
sudo useradd devops
echo -e 'devops\ndevops' | sudo passwd devops
echo 'devops ALL=(ALL) NOPASSWD: ALL' | sudo tee /etc/sudoers.d/devops

#echo '[ansible]' > /home/devops/inventory
#echo 'ansible-engine ansible_host=${aws_instance.ansible-engine.private_dns} ansible_connection=local' >> /home/devops/inventory
#echo '[nodes]' >> /home/devops/inventory
#echo 'node ansible_host=182.168.100.4' >> /home/devops/inventory
#echo 'node2 ansible_host=${aws_instance.ansible-nodes[1].private_dns}' >> /home/devops/inventory
#echo '' >> /home/devops/inventory
#echo '[all:vars]' >> /home/devops/inventory
#echo 'ansible_user=devops' >> /home/devops/inventory
#echo 'ansible_password=devops' >> /home/devops/inventory
#echo 'ansible_connection=ssh' >> /home/devops/inventory
#echo '#ansible_python_interpreter=/usr/bin/python3' >> /home/devops/inventory
#echo 'ansible_ssh_private_key_file=/home/devops/.ssh/id_rsa' >> /home/devops/inventory
#echo \"ansible_ssh_extra_args=' -o StrictHostKeyChecking=no -o PreferredAuthentications=password '\" >> /home/devops/inventory
#echo '[defaults]' >> /home/devops/ansible.cfg
#echo 'inventory = ./inventory' >> /home/devops/ansible.cfg
#echo 'host_key_checking = False' >> /home/devops/ansible.cfg
#echo 'remote_user = devops' >> /home/devops/ansible.cfg