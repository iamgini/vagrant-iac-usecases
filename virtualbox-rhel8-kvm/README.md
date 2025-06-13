```shell
$ sudo dnf install -y cockpit && \
  sudo dnf install -y cockpit-machines && \
  sudo dnf module install -y virt

$ sudo systemctl start libvirtd
$ sudo systemctl start cockpit

# now access the cock pit at IP_Address:9090
```