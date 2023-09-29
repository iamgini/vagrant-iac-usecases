Doc to install oracle db

https://www.centlinux.com/2021/12/install-oracle-database-21c-on-rhel-8.html

```shell
sudo dnf install -y  \
 bc \
 binutils \
 compat-openssl10 \
 elfutils-libelf \
 glibc \
 glibc-devel \
 ksh \
 libaio \
 libXrender \
 libX11 \
 libXau \
 libXi \
 libXtst \
 libgcc \
 libnsl \
 libstdc++ \
 libxcb \
 libibverbs \
 make \
 policycoreutils \
 policycoreutils-python-utils \
 smartmontools \
 sysstat \
 libnsl2 \
 libnsl2-devel \
 net-tools \
 nfs-utils \
 unzip
```

```shell
groupadd -g 1501 oinstall
groupadd -g 1502 dba
groupadd -g 1503 oper
groupadd -g 1504 backupdba
groupadd -g 1505 dgdba
groupadd -g 1506 kmdba
groupadd -g 1507 racdba
useradd -u 1501 -g oinstall -G dba,oper,backupdba,dgdba,kmdba,racdba oracle
echo "oracle" | passwd oracle --stdin
```


```shell
./runInstaller -ignorePrereq -waitforcompletion -silent \
  oracle.install.option=INSTALL_DB_SWONLY \
  ORACLE_HOSTNAME=${ORACLE_HOSTNAME} \
  UNIX_GROUP_NAME=oinstall \
  INVENTORY_LOCATION=${ORA_INVENTORY} \
  ORACLE_HOME=${ORACLE_HOME} \
  ORACLE_BASE=${ORACLE_BASE} \
  oracle.install.db.InstallEdition=EE \
  oracle.install.db.OSDBA_GROUP=dba \
  oracle.install.db.OSBACKUPDBA_GROUP=backupdba \
  oracle.install.db.OSDGDBA_GROUP=dgdba \
  oracle.install.db.OSKMDBA_GROUP=kmdba \
  oracle.install.db.OSRACDBA_GROUP=racdba \
  SECURITY_UPDATES_VIA_MYORACLESUPPORT=false \
  DECLINE_SECURITY_UPDATES=true
```