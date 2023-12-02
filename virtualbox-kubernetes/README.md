# Kubernetes cluster with Vagrant and Ansible

Read the full guide here: [Multi-node Kubernetes Cluster in 10 minutes](https://www.techbeatly.com/kubernets-cluster-in-10-minutes/)

```shell
## clone the repo
$ git clone https://github.com/ginigangadharan/vagrant-iac-usecases

## swith to the directory
$ cd virtualbox-kubernetes

## create cluster
$ vagrant up
```
Wait for nodes to power on and install packages (5-10 min depends on your configuration)

```shell
## chcek status
$ vagrant status
Current machine states:

controlplane              running (virtualbox)
compute-1                 running (virtualbox)
compute-2                 running (virtualbox)
```

## Access the Cluster

```shell
## login to controlplane node (use the correct controlplane node name)
$ vagrant ssh controlplane

## export kubeconfig
vagrant@demo-k8s-controlplane:~$ export KUBECONFIG=$HOME/.kube/config

## check nodes
vagrant@demo-k8s-controlplane:~$ kubectl get nodes
NAME                STATUS     ROLES                  AGE     VERSION
demo-compute-1      NotReady   <none>                 7m51s   v1.23.5
demo-compute-2      NotReady   <none>                 5m20s   v1.23.5
demo-controlplane   NotReady   control-plane,master   10m     v1.23.5     
```

## Install CNI

Install any of the preferred CNI.

### a) Install Flannel

```shell
vagrant@demo-k8s-controlplane:~$ kubectl apply -f https://github.com/coreos/flannel/raw/master/Documentation/kube-flannel.yml
```
### Install Calico Network


```shell
## swtich to /vagrant directory on demo-k8s-controlplane
## content of your Vagrant project directory will be mounted there.
vagrant@demo-k8s-controlplane:~$ cd /vagrant/

## Intall calico and wait for pods to create
vagrant@demo-k8s-controlplane:/vagrant$ kubectl create -f calico.yaml

## Wait for Calico pods to create and running
vagrant@demo-k8s-controlplane:/vagrant$ kubectl get po -n kube-system |grep calico

## Wait for coredns pods to create and running
vagrant@demo-k8s-controlplane:/vagrant$ kubectl get po -n kube-system |grep coredns
```

## Install and Access Dashboard

Check [documentation](https://kubernetes.io/docs/tasks/access-application-cluster/web-ui-dashboard/) for latest version of Kubernetes dashboard.

```shell
## install dashboard resources
vagrant@demo-k8s-controlplane:~$ kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.4.0/aio/deploy/recommended.yaml

## Get Token to Access Dashboard
vagrant@demo-k8s-controlplane:~$ KUBETOKEN=$(kubectl -n kube-system get secret | grep default-token | awk '{print $1}')

## Copy Token Value from below command
vagrant@demo-k8s-controlplane:~$ kubectl -n kube-system describe secret ${KUBETOKEN} | grep token: | awk '{print $2}'
```

Note: You can also create a seperate user for accessing the dashboard; refer [Creating Sample User documentation](https://github.com/kubernetes/dashboard/blob/master/docs/user/access-control/creating-sample-user.md).

**Enable proxy**

```shell
vagrant@demo-k8s-controlplane:~$ kubectl proxy --address='0.0.0.0'
Starting to serve on [::]:8001
```

Now you can open the url from you host machine browser as [`http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/`](http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/) (Port forwarding has been enabled as part of `Vagrantfile`)

## Install Metrics server

```shell
$ kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml
```

**Notes:**

1. Tested on linux, mac, ~~Windows~~(Need to adjust Ansible dependancy)
2. ~~Ansible will be installed inside the VM to keep compatibility on Windows; so no Ansible prerequisite on main host~~. Ansible is required at the moment; you can adjust the value from `"ansible" do |ansible|` to `"ansible_local" do |ansible|` for using local Ansible inside VM.
3. You can adjust the number of compute nodes by editing `COMPUTE_NODES = 2` inside the Vagrantfile.

## Troubleshooting

```shell
$sudo crictl config --set runtime-endpoint=unix:///run/containerd/containerd.sock --set image-endpoint=unix:///run/containerd/containerd.sock 
$ cat /etc/crictl.yaml
runtime-endpoint: "unix:///run/containerd/containerd.sock"
image-endpoint: "unix:///run/containerd/containerd.sock"
timeout: 0
debug: false
pull-image-on-create: false
disable-pull-on-run: false
```


```shell
sudo kubeadm init --apiserver-advertise-address=192.168.56.50 --apiserver-cert-extra-sans=192.168.56.50 --node-name=demo-k8s-controlplane --pod-network-cidr=192.168.0.0/16
```
# References

There are many guides to deploy kubernetes using Vagrant and VirtualBox; if above solution is not working for you, you maye refer other references as well.

- [Kubernetes Setup Using Ansible and Vagrant](https://kubernetes.io/blog/2019/03/15/kubernetes-setup-using-ansible-and-vagrant/)
- [How To Create a Kubernetes Cluster Using Kubeadm on Ubuntu 18.04](https://www.digitalocean.com/community/tutorials/how-to-create-a-kubernetes-cluster-using-kubeadm-on-ubuntu-18-04)
- [How to Setup Kubernetes Cluster on Vagrant VMs](https://devopscube.com/kubernetes-cluster-vagrant/)
- [Container runtimes](https://kubernetes.io/docs/setup/production-environment/container-runtimes)
- [How to create a Kubernetes cluster with Kubeadm and Ansible on Ubuntu 20.04](https://www.arubacloud.com/tutorial/how-to-create-kubernetes-cluster-with-kubeadm-and-ansible-ubuntu-20-04.aspx)
- [KEP-2067: Rename the kubeadm "master" label and taint](https://github.com/kubernetes/enhancements/blob/master/keps/sig-cluster-lifecycle/kubeadm/2067-rename-master-label-taint/README.md)
- [Deploy Kubernetes Cluster on Ubuntu 20.04 with Containerd](https://www.hostafrica.ng/blog/kubernetes/kubernetes-ubuntu-20-containerd/)