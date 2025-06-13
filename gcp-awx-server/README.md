# Ansible AWX Server - Using Vagrant iac 
(Infra as a Code)

AWX provides a web-based user interface, REST API, and task engine built on top of Ansible. It is the upstream project for Tower, a commercial derivative of AWX.
[Learn More](https://github.com/ansible/awx)

## Pre-Req

Refer **[READEME](https://github.com/ginigangadharan/vagrant-iac-usecases/blob/master/README.md)** for environment setup

**See More use cases at [vagrant-iac-use cases](https://github.com/ginigangadharan/vagrant-iac-usecases)**

## Build AWX Sandbox
- Clone [master repo](https://github.com/ginigangadharan/vagrant-iac-usecases)
- Switch to `gcp-iac-awx-server` directory
- `vagrant up --provider=google`
