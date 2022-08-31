sudo sed -i "s/PasswordAuthentication no/PasswordAuthentication yes/g" /etc/ssh/sshd_config
sudo systemctl restart sshd

# add devops user
sudo useradd -m devops
#echo -e 'devops\ndevops' | sudo passwd devops2022
echo 'devops ALL=(ALL) NOPASSWD: ALL' | sudo tee /etc/sudoers.d/devops

sudo su - devops && python3 -m ensurepip --upgrade --user
sudo su - devops && python3 -m pip install --user pip --upgrade 
sudo su - devops && python3 -m pip install ansible --user

#sudo dnf -y install podman vim git
sudo dnf -y install git

# clone sample repo
sudo su - devops && git clone https://github.com/ginigangadharan/ansible-real-life /home/devops/ansible-real-life
#sudo su - devops && chown -R devops:devops /home/devops/ansible-real-life/

# setup ssh key access
cat host_ssh_public_key >> /home/vagrant/.ssh/authorized_keys
mkdir -p /home/devops/.ssh/
cat host_ssh_public_key >> /home/devops/.ssh/authorized_keys
chown -R devops:devops /home/devops/
chmod 600 /home/devops/.ssh/authorized_keys

# Get IP Details
ip a 
