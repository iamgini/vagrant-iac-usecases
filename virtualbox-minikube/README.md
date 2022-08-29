# Installing minikube with Vagrant and Ansible

This is a simple repo to demonstrate how to install minikube inside a virtualbox vm using Vagrant and Ansible as provisioner. 

Watch **[video](https://www.youtube.com/watch?v=xPLQqHbp9BM&t=2s)** for detailed explanaton.

**Important Note**
If you are planning to other variants of box (ubuntu or debian instead of CentOS), make sure you adjust your Ansible playbook (`install-minikube.yaml`) accordingly.

![minikube-vagrant-iac](../images/minikube-vagrant-iac.png)

## How to use this repo - Quick Overview

1. Install Vagrant
   
2. ~~Install Ansible~~ 

**Update**
Since some of the users reported that, they are using Windows and unable to use Ansible, I have adjusted the Vagrantfile to use with `ansible_local` option.

3. Clone this repo to your working directory

`git clone git@github.com:ginigangadharan/vagrant-iac-usecases.git`

4. switch to `vagrant-iac-use cases/virtualbox-iac-minikube` directory and run `vagrant up`

## Additional Notes

minikube will be installed and running with default components. If you want to enable additional components add those using `minikube enable` command.

Eg: Enable `metrics-server`

```shell
[vagrant@centos-minikube ~]$ sudo minikube addons enable metrics-server
* The 'metrics-server' addon is enabled
```

## References
- [Installing Kubernetes with Minikube](https://kubernetes.io/docs/setup/learning-environment/minikube/)
- [minikube start](https://minikube.sigs.k8s.io/docs/start/)
- [minikube](https://technology.amis.nl/2019/02/12/rapidly-spinning-up-a-vm-with-ubuntu-docker-and-minikube-using-the-vm-drivernone-option-on-my-windows-laptop-using-vagrant-and-oracle-virtualbox/)