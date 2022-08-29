sudo sed -i "s/PasswordAuthentication no/PasswordAuthentication yes/g" /etc/ssh/sshd_config
sudo systemctl restart sshd

sudo python3 -m pip install pip --upgrade
#sudo su - devops && python3 -m pip install ansible --user

sudo dnf -y install podman vim git

# add devops user
sudo useradd -m devops
echo -e 'devops\ndevops' | sudo passwd devops
echo 'devops ALL=(ALL) NOPASSWD: ALL' | sudo tee /etc/sudoers.d/devops

# clone sample repo
git clone https://github.com/ginigangadharan/ansible-real-life /home/devops/ansible-real-life
chown -R devops:devops /home/devops/ansible-real-life/
