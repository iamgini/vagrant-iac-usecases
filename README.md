# Vagrant IaC (Infrastructure as Code) Use Cases

Using Vagrant for Quick Sandboxes.

This is a simple repo to demonstrate how to implement iac using Vagrant on AWS, GCP, VMWare, VirtualBox etc. We have implemented **iac (Infra-a-Code)** and CaC(Configuration-as-Code) using Vagrant and Ansible. 

microsoft.com
![IaC](images/infrastructureascode_600x300-3.png)

*Image: microsoft.com*

## Sample Use cases:

See some of the subdirectories for sample usage.

- Create an AWX (Ansible Web UI)server for demo (INPG)
- Create application server for develpers on everyday with same spec and destroy when finished
- Create a webserver with nginx installed and configured in GCP or AWS
- Create minikube or kubernetes
- Create Yum Repo server
- Deploy OpenShift (OKD) Single node cluster

Questions : [iamgini.com](http://www.iamgini.com)

<!-- TOC orderedlist:false -->

- [Vagrant IaC (Infrastructure as Code) Use Cases](#vagrant-iac-infrastructure-as-code-use-cases)
  - [Sample Use cases:](#sample-use-cases)
  - [How to use this repo - Quick Overview](#how-to-use-this-repo---quick-overview)
  - [What Vagrant iac can do ?](#what-vagrant-iac-can-do-)
  - [Setup Provider Environment](#setup-provider-environment)
    - [AWS Setup](#aws-setup)
    - [Google Cloud Platform Setup](#google-cloud-platform-setup)
  - [Step 1 - Configure Pre-requisites](#step-1---configure-pre-requisites)
    - [Vagrant Installation](#vagrant-installation)
    - [Plugin Installation](#plugin-installation)
    - [Setup Provider Environment - GCP/AWS/VMWare](#setup-provider-environment---gcpawsvmware)
    - [Box Image](#box-image)
  - [Step 2 - Create our Virtual Machine](#step-2---create-our-virtual-machine)
    - [Vagrantfile](#vagrantfile)
    - [Provisioning](#provisioning)
      - [When provisioning happens ?](#when-provisioning-happens-)
    - [Let's create the VM](#lets-create-the-vm)
    - [Verify our instance](#verify-our-instance)
    - [Stop or Delete VM](#stop-or-delete-vm)
    - [Troubleshooting](#troubleshooting)
      - [vagrant up hang at "==> default: Waiting for SSH to become available..."](#vagrant-up-hang-at--default-waiting-for-ssh-to-become-available)

<!-- /TOC -->

## How to use this repo - Quick Overview

1. Install Vagrant
2. Configure GCP/AWS/Other credentials.
3. Clone this repo to your working directory

`git clone git@github.com:ginigangadharan/vagrant-iac-usecases.git`

4. switch to `vagrant-iac-use cases/gcp-iac-web-demo` directory and run `vagrant up --provider=google` (or other directories for other use cases)

See below for detailed instructions.

## What Vagrant iac can do ?

This repo contains multiple use cases to demonstrate how to implement IaC (Infrastructure as Code) using **Vagrant** on GCP, AWS, VirtualBox, VMware(INPG) etc

- This **IaC** will create  Virtual Machine(s) in **GCP,AWS etc** 
- It will install required application inside the VM (we will use ansible as provisioner)
    - eg: install nginx and add website content from [github sample site](https://github.com/ginigangadharan/demo-website-content.git) etc.
- It will configure system with required settings.
    - enable firewall and root login securities automatically using ansible provisioning. 

## Setup Provider Environment 

We need to configure provider (GCP or AWS) credential accordingly.

### AWS Setup
3.1 Make sure you have a proper **security group** created in your VPC (under your AWS account) with SSH, HTTP/HTTPS allowed.
3.2 Make sure you have created a **keypair** for this purpose and key file (**.pem** format) has been kept at a secure location on your machine.
3.3 Get your **access credentials** from AWS console. ([Refer my AWI CLI installation article](https://www.techbeatly.com/2018/03/how-to-install-and-configure-aws-command-line-interface-cli.html/#how-to-get-aws-credentials)). Add the same in ```~/.aws/credentials``` file.

```
# aws configure --profile devops
AWS Access Key ID [None]: AKIAJVOHCIQ72EXAMPLE
AWS Secret Access Key [None]: 7l/j/hxXeEA77/7e+7ZvLLBQW9SxdcEXAMPLEKEY
Default region name [None]: us-west-2
Default output format [None]: json
```

Verify content in the files
```
# mkdir ~/.aws
# cd ~/.aws/
# cat credentials 
[default]
aws_access_key_id=AKIAIOSFODNN7EXAMPLE
aws_secret_access_key=wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY

[devops]
aws_access_key_id=AKIAJVOHCIQ72EXAMPLE
aws_secret_access_key=7l/j/hxXeEA77/7e+7ZvLLBQW9SxdcEXAMPLEKEY

# cat config 
[default] 
region=us-west-2 output=json 
[devops] 
region=us-west-2 output=json
```

### Google Cloud Platform Setup

Prior to using this plugin, you will first need to make sure you have a 
Google Cloud Platform account, enable Google Compute Engine, and create a
Service Account for API Access.

1. Log in with your Google Account and go to
   [Google Cloud Platform](https://cloud.google.com) and click on the
   `Try it free` button.
1. Create a new project and remember to record the `Project ID`
1. Next, enable the
   [Google Compute Engine API](https://console.cloud.google.com/apis/api/compute_component/)
   for your project in the API console. If prompted, review and agree to the
   terms of service.
1. While still in the API Console, go to
   [Credentials subsection](https://console.cloud.google.com/apis/credentials),
   and click `Create credentials` -> `Service account key`. In the
   next dialog, create a new service account, select `JSON` key type and
   click `Create`.
1. Download the JSON private key and save this file in a secure
   and reliable location.  This key file will be used to authorize all API
   requests to Google Compute Engine.
1. Still on the same page, click on
   [Manage service accounts](https://console.cloud.google.com/permissions/serviceaccounts)
   link to go to IAM console. Copy the `Service account id` value of the service
   account you just selected. (it should end with `gserviceaccount.com`) You will
   need this email address and the location of the private key file to properly
   configure this Vagrant plugin.
1. Add the SSH key you're going to use to GCE Metadata in `Compute` ->
   `Compute Engine` -> `Metadata` section of the console, `SSH Keys` tab. (Read
   the [SSH Support](https://github.com/mitchellh/vagrant-google#ssh-support)
   readme section for more information.)
   

## Step 1 - Configure Pre-requisites

To test this demo, you need to follow below items.

### Vagrant Installation

[Download](https://www.vagrantup.com/downloads.html) and install vagrant on your host/workstation. (Your laptop or a control server)

Refer [Vagrant Documentation](https://www.vagrantup.com/docs/installation/) for more details.

### Plugin Installation

Vagrant is coming with support for VirtualBox, Hyper-V, and Docker. If you want to create your virtual machine on any other environment (like AWS or Azure) Vagrant still has the ability to manage this but only by using  providers plugins. 

```shell
vagrant plugin install vagrant-google

# or

vagrant plugin install vagrant-digitalocean 
vagrant plugin install vagrant-omnibus
vagrant plugin install vagrant-aws
```

File transfer between host and guest VM

```shell
vagrant plugin install vagrant-vbguest
vagrant plugin install vagrant-scp
```

*If any issues during installation, then try with installing dependencies. (Depends on the workstation machine you are using, packages and version may change)*

```
yum -y install gcc ruby-devel rubygems compass
```

**Mac Users** : If you are getting an error ```OS-X, Rails: “Failed to build gem native extension”```, then you need to setup xcode.
Instal ```xcode-select --install```.

### Setup Provider Environment - GCP/AWS/VMWare

- Make sure you have a proper **firewall** rules in place with SSH, HTTP/HTTPS allowed.

- Make sure you have created a **keypair** for this purpose and key file has been kept at a secure location on your machine. (eg: `~/.ssh/id_rsa`)

- Get your **access credentials** from GCP/AWS console. And save somewhere secure (eg: `~/.gc/YOUR-API-KEY.json`)

### Box Image 

In normal case with VirtualBox or HyberV, we need to give proper box details to load the image (like a template or clone). But in this case we are using GCP Imageand config.vm.box is just for a vagrant syntax purpose. 

You can either add a dummy box(``` vagrant box add aws-dummy https://github.com/mitchellh/vagrant-aws/raw/master/dummy.box ```) or just use any available box image, just like what I did in Vagrantfile.

(You can choose any box by searching [here](https://app.vagrantup.com/boxes/search?provider=google) for working with VirtualBox, Hyper-V or Docker)

## Step 2 - Create our Virtual Machine

Vagrant is managed inside a project directory (anywhere at your convenience, eg: your home dir) where we save Vagrantfile, other provisioning scripts etc (bash or ansible playbooks).

### Vagrantfile
We have **Vagrantfile** where we specify what type of VM we are creating, what are the specifications needed etc. You may refer [Vagrantfile](Vagrantfile) in this project for reference. (Items are explained inside the file)

### Provisioning 
Vagrant Provisioners will help to automatically install software, update configurations etc as part of the vagrant up process. You can use any available provisioning method as Vagrant will support most of the build and configuration management softwares. (eg: bash, ansible, puppet, chef etc). 
Refer [Provisioning doc](https://www.vagrantup.com/docs/provisioning/)

We have used **Ansible** as provisioner and created a playbook called [deploy-infra.yaml](deploy-infra.yaml) in which we have mentioned what are the configurations we need on the server (VM) once its created. All tasks in playbook are self explanatory but i am listing down them for reference.
1. Create the directory for storing our website (/webapp/main-site)
2. Install nginx server
3. Start nginx service
4. Copy nginx configuration ([static_site.cfg](static_site.cfg) to /etc/nginx/sites-available/static_site.cfg on VM)
5. Create symlink to activate the site (from /etc/nginx/sites-available to /etc/nginx/sites-enabled/)
6. Clone website from github to /webapp/main-site
7. Restart nginx to load configuratioins
8. Install ufw (firewall)
9. Start Firewall service
10. Setup ufw and enable for reboot
11. Enable ssh and http ports
12. Disallow password authentication
13. Disallow root SSH access
14. Collect Public Hostname/Url to access
15. Verify website access

And we have 2 handlers in playbook
1. Restart ssh
2. Show public url


#### When provisioning happens ?

- When we run first ```vagrant up``` provisioning is run after creating this instance. 
- When ```vagrant provision``` is used on a running environment.
- When ```vagrant reload --provision``` is called. (If you have a change in provision script, just edit the yaml file and run this.)

### Let's create the VM

Now, we will switch to the Vagrant project directory (vagrant-web) and create the VM.

```
# cd vagrant-web
# vagrant up
```
Wait for vagrant to create instance and provision software/configurations using ansible.

### Verify our instance

If all goes well, you will see success message as well as a **public hostname url** in this case. We can access the url from browser and verify the website. (We have already a check inside the playbook to verify url access)

Also you can access the instance using ssh as below.

`vagrant ssh`

### Stop or Delete VM

`vagrant destroy`

### Troubleshooting

#### vagrant up hang at "==> default: Waiting for SSH to become available..."
This is due to wrong ssh configurations; you need to make sure
- Your .pem key has correct permission and ownership
- You have used correct Security Group (with ssh access) in Vagrantfile
- You have used correct keypair details in Vagrantfile
