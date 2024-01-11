# Ansible Lab using Vagrant and VirtualBox

A simple Vagrantfile to provision multi-node Kubernetes Lab for practicing.

## Features

- Based on Fedora 38

**Important notes**:

- DO NOT keep any important files or playbooks inside the VM as it may delete when you delete/restart the VM(s) using `vagrant`.
- Keep your configurations and playbooks in Git repos (GitHub, GitLab etc)
- These labs are meant for immutable and you can destroy and recreate many times as needed.

## Prerequisites

- [Vagrant](https://developer.hashicorp.com/vagrant/docs/installation) is installed (tested with 2.3.6).
- [VirtualBox](https://www.virtualbox.org/wiki/Downloads) is installed.
- Internet connectivity (to download the vagrant boxes and other packages.)
- Ansible installed on workstation (using Ansible for most of the provisioning jobs)
- Install Ansible collections from requirements.yml

```shell
$ ansible-galaxy install -r requirements.yml
```


## How to use this repository

1. Clone or download the repository

```shell
$ git clone https://github.com/iamgini/vagrant-iac-usecases.git
```

If the Git is not available on the system (it is recommended to install and use git) you can download the repo and extract the content.

2. Switch to the directory

```shell
$ cd virtualbox-kubernetes-bible-2E
```

3. Create the lab using `vagrant up` command.

```Shell
$ vagrant up
```

4. Verify the VM created

#TODO

```shell

$ vagrant status
Current machine states:

ansible-lab-node-1        running (virtualbox)
ansible-lab-node-2        running (virtualbox)
ansible-lab-control       running (virtualbox)

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
[vagrant@ansible-lab-control ~]$ ansible --version
ansible [core 2.14.6]
  config file = /home/vagrant/ansible.cfg
  configured module search path = ['/home/vagrant/.ansible/plugins/modules', '/usr/share/ansible/plugins/modules']
  ansible python module location = /usr/lib/python3.11/site-packages/ansible
  ansible collection location = /home/vagrant/.ansible/collections:/usr/share/ansible/collections
  executable location = /usr/bin/ansible
  python version = 3.11.2 (main, Feb  8 2023, 00:00:00) [GCC 13.0.1 20230208 (Red Hat 13.0.1-0)] (/usr/bin/python3)
  jinja version = 3.0.3
  libyaml = True
```

Test remote nodes connection

```shell
[vagrant@ansible-lab-control ~]$ ansible all -m ping
ansible-lab-control | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python3"
    },
    "changed": false,
    "ping": "pong"
}
ansible-lab-node-1 | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python3"
    },
    "changed": false,
    "ping": "pong"
}
ansible-lab-node-2 | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python3"
    },
    "changed": false,
    "ping": "pong"
}
```

## Using on Windows

```shell
gini@Win11WS MINGW64 ~/vagrant-iac-usecases/virtualbox-ansible-lab (master)
$ ssh-keygen.exe
Generating public/private rsa key pair.
Enter file in which to save the key (/c/Users/gini/.ssh/id_rsa): Created directory '/c/Users/gini/.ssh'.
Enter passphrase (empty for no passphrase):
Enter same passphrase again:
Your identification has been saved in /c/Users/gini/.ssh/id_rsa
Your public key has been saved in /c/Users/gini/.ssh/id_rsa.pub
The key fingerprint is:
SHA256:4B56IDTKW6GcmnBaMotaSOz66EX3pMVG+ZsTrgEDz88 gini@Win11WS
The key's randomart image is:
+---[RSA 3072]----+
|                 |
|        .        |
|  oo  .o         |
|+oo.=.o..        |
|=B+o.*o=So       |
|*X+..+@.. +      |
|Bo....oE =       |
|oo.  .  o .      |
|=o.    .         |
+----[SHA256]-----+

gini@Win11WS MINGW64 ~/vagrant-iac-usecases/virtualbox-ansible-lab (master)
$ ls -la ~/.ssh/
total 13
drwxr-xr-x 1 gini 197121    0 Aug 12 00:17 ./
drwxr-xr-x 1 gini 197121    0 Aug 12 00:16 ../
-rw-r--r-- 1 gini 197121 2602 Aug 12 00:17 id_rsa
-rw-r--r-- 1 gini 197121  566 Aug 12 00:17 id_rsa.pub

```