# kubernetes cluster with Kubespray
Vagrant and Ansible

# Deploy cluster by execute cluster.yml playbook

```
ansible-playbook -i inventory/mycluster/hosts.yml cluster.yml -b -v \
  --private-key=~/.ssh/private_key
```