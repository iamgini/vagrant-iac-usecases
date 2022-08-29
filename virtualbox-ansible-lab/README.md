# Ansible Lab using Vagrant and VirtualBox

A simple Vagrantfile to provision multi-node Ansible Lab for practicing.

Notes:
- DO NOT keep any important files or playbooks inside the VM as it may delete when you delete/restart VM using `vagrant`.
- Keep your playbooks in Git repos (GitHub, GitLab etc)
- These labs are meant for immutable in nature and you can destroy and recreate many times as needed.

## How to use this repository

1. Clone or download the repository

```shell
$ git clon https://github.com/ginigangadharan/vagrant-iac-usecases.git
```

If the Git is not available on the syestem (it is recommended to instll and use git) you can download the repo and extract the content.

2. Switch to the directory

```shell
$ cd virtualbox-ansible-lab
```

3. Create the lab using `vagrant up` command.

```Shell
$ vagrant up
```

4. Verify the VM created

```shell

$ vagrant status
Current machine states:

ansible-node-1            running (virtualbox)
ansible-node-2            running (virtualbox)
ansible-engine            running (virtualbox)

This environment represents multiple VMs. The VMs are all listed
above with their current state. For more information about a specific
VM, run `vagrant status NAME`.
```

You can also check the VM status from VirtualBox GUI.

5. Access the lab

```shell
$ vagrant ssh ansible-engine
[vagrant@ansible-engine1 ~]$ 
```

Check Ansible version

```shell
[vagrant@ansible-engine1 ~]$ ansible --version
ansible 2.9.27
  config file = /etc/ansible/ansible.cfg
  configured module search path = ['/home/vagrant/.ansible/plugins/modules', '/usr/share/ansible/plugins/modules']
  ansible python module location = /usr/lib/python3.10/site-packages/ansible
  executable location = /usr/bin/ansible
  python version = 3.10.0 (default, Oct  4 2021, 00:00:00) [GCC 11.2.1 20210728 (Red Hat 11.2.1-1)]
```