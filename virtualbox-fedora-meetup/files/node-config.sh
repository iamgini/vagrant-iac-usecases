sudo sed -i "s/PasswordAuthentication no/PasswordAuthentication yes/g" /etc/ssh/sshd_config
sudo systemctl restart sshd

python -m ensurepip --upgrade
python3 -m pip install pip --upgrade


sudo dnf -y install podman vim git

# add devops user
sudo useradd -m devops
echo -e 'devops\ndevops' | sudo passwd devops
echo 'devops ALL=(ALL) NOPASSWD: ALL' | sudo tee /etc/sudoers.d/devops

# Install ansible for devops user
sudo su - devops && python3 -m pip install ansible --user

# clone sample repo
git clone https://github.com/ginigangadharan/ansible-real-life /home/devops/ansible-real-life
chown -R devops:devops /home/devops/ansible-real-life/

# setup ssh key access
cat host_ssh_public_key >> /home/vagrant/.ssh/authorized_keys
mkdir -p /home/devops/.ssh/
cat host_ssh_public_key >> /home/devops/.ssh/authorized_keys
chown -R devops:devops /home/devops/
chmod 600 /home/devops/.ssh/authorized_keys
