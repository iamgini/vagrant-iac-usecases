# VirtualBox - RHEL 9 Utils (Nginx)

A Vagrant setup for a RHEL 9 utility server with nginx, firewalld configured for HTTP/HTTPS, and a `devops` user with passwordless sudo and SSH key access.

## Prerequisites

- [VirtualBox](https://www.virtualbox.org/) (7.x recommended)
- [Vagrant](https://www.vagrantup.com/) (2.4+ for VirtualBox 7.2 support)
- [Ansible](https://docs.ansible.com/) (installed on the host)

## Usage

```bash
# Bring up the VM
vagrant up --provider=virtualbox

# SSH into the VM
vagrant ssh rhel9-utils-1

# Check status
vagrant status

# Stop the VM
vagrant halt

# Destroy the VM
vagrant destroy -f
```

## What gets provisioned

- `devops` user with passwordless sudo and your `~/.ssh/id_rsa.pub`
- SSH password authentication enabled
- nginx installed, started, and enabled
- firewalld ports 80 (HTTP) and 443 (HTTPS) opened

## Configuration

| Setting  | Default         |
|----------|-----------------|
| Box      | `generic/rhel9` |
| Nodes    | 1               |
| Memory   | 512 MB          |
| CPUs     | 1               |

## Other Examples

See the [repository root](../) for more Vagrant setups, including:

- [`virtualbox-rhel9-generic`](../virtualbox-rhel9-generic) - Base RHEL 9 (no nginx)
- [`virtualbox-rhel9-aap25`](../virtualbox-rhel9-aap25) - RHEL 9 with Ansible Automation Platform
- [`virtualbox-rhel8-generic`](../virtualbox-rhel8-generic) - Generic RHEL 8
