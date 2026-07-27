# VirtualBox - Generic RHEL 9

A minimal Vagrant setup for spinning up a generic Red Hat Enterprise Linux 9 virtual machine on VirtualBox. Useful for quick testing, learning, or as a base for further provisioning.

## Prerequisites

- [VirtualBox](https://www.virtualbox.org/) (7.x recommended)
- [Vagrant](https://www.vagrantup.com/) (2.4+ for VirtualBox 7.2 support)
- [Ansible](https://docs.ansible.com/) (installed on the host)

## Usage

```bash
# Bring up the VM
vagrant up --provider=virtualbox

# SSH into the VM
vagrant ssh rhel-9-1

# Check status
vagrant status

# Stop the VM
vagrant halt

# Destroy the VM
vagrant destroy -f
```

## Configuration

| Setting  | Default         |
|----------|-----------------|
| Box      | `generic/rhel9` |
| Nodes    | 1               |
| Memory   | 512 MB          |
| CPUs     | 1               |

Edit `NODES` in the `Vagrantfile` to spin up multiple instances.

## Provisioning

On `vagrant up`, the VM is automatically provisioned with:

1. Your host SSH public key (`~/.ssh/id_rsa.pub`) added for direct SSH access as `vagrant` user
2. An Ansible playbook (`files/config.yaml`) that populates `/etc/hosts`

## Adding a devops user with sudo and SSH access

This repo does not include the devops user setup by default, but other folders in this repo have Ansible playbooks that create a `devops` user with passwordless sudo and your local SSH public key. You can reuse them as-is or copy the relevant tasks into `files/config.yaml`.

Reference playbooks:

- [`virtualbox-rhel9-aap25/files/config.yaml`](../virtualbox-rhel9-aap25/files/config.yaml) - Creates `devops` user, sets password, grants passwordless sudo, and copies `~/.ssh/id_rsa.pub` to authorized_keys
- [`virtualbox-rhel9-aap-dashboard/files/config.yaml`](../virtualbox-rhel9-aap-dashboard/files/config.yaml) - Same setup using `ansible.posix.authorized_key` module (more robust for key management)

Both playbooks also enable SSH password authentication on the VM.

To run one of them against this VM after it's up:

```bash
ansible-playbook -i .vagrant/provisioners/ansible/inventory/vagrant_ansible_inventory \
  ../virtualbox-rhel9-aap25/files/config.yaml
```

Or SSH in directly as the devops user once provisioned:

```bash
ssh devops@127.0.0.1 -p 2222
```

## Other Examples

This repo contains many more Vagrant setups for different use cases:

- [`virtualbox-rhel8-generic`](../virtualbox-rhel8-generic) - Generic RHEL 8 machine
- [`virtualbox-ansible-lab`](../virtualbox-ansible-lab) - Multi-node Ansible lab environment
- [`virtualbox-kubernetes`](../virtualbox-kubernetes) - Kubernetes cluster setup
- [`virtualbox-rhel9-aap`](../virtualbox-rhel9-aap) - RHEL 9 with Ansible Automation Platform
- [`virtualbox-rhel9-aap25`](../virtualbox-rhel9-aap25) - RHEL 9 with AAP 2.5 (includes devops user provisioning)
- [`virtualbox-fedora`](../virtualbox-fedora) - Fedora workstation
- [`virtualbox-ubuntu`](../virtualbox-ubuntu) - Ubuntu machine
- [`virtualbox-sysadmin-rhel8`](../virtualbox-sysadmin-rhel8) - RHEL 8 sysadmin lab (includes devops user setup)

See the full list in the [repository root](../).
