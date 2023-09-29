Setup a Yum repo server
======================

https://access.redhat.com/labs/yumrepoconfighelper/

https://www.tecmint.com/setup-local-http-yum-repository-on-centos-7/

- install nginx
# yum install epel-release
# yum install nginx     

- enable and start nginx
# systemctl start nginx
# systemctl enable nginx
# systemctl status nginx

- enable http and https in firewall
# firewall-cmd --zone=public --permanent --add-service=http
# firewall-cmd --zone=public --permanent --add-service=https
# firewall-cmd --reload

- install yum-utils
# yum install createrepo  yum-utils

- create directories for repo files
# mkdir -p /var/www/html/repos/{base,centosplus,extras,updates}

- use reposync to sync CentOS repo to locally 
# reposync -g -l -d -m --repoid=base --newest-only --download-metadata --download_path=/var/www/html/repos/
# reposync -g -l -d -m --repoid=centosplus --newest-only --download-metadata --download_path=/var/www/html/repos/
# reposync -g -l -d -m --repoid=extras --newest-only --download-metadata --download_path=/var/www/html/repos/
# reposync -g -l -d -m --repoid=updates --newest-only --download-metadata --download_path=/var/www/html/repos/

In the above commands, the option:
    -g – enables removing of packages that fail GPG signature checking after downloading.
    -l – enables yum plugin support.
    -d – enables deleting of local packages no longer present in repository.
    -m – enables downloading of comps.xml files.
    --repoid – specifies the repository ID.
    --newest-only – tell reposync to only pull the latest version of each package in the repos.
    --download-metadata – enables downloading all the non-default metadata.
    --download_path – specifies the path to download packages.


- check packages and file inside repos directories
# ls -l /var/www/html/repos/base/
# ls -l /var/www/html/repos/base/Packages/
# ls -l /var/www/html/repos/centosplus/
# ls -l /var/www/html/repos/centosplus/Packages/
# ls -l /var/www/html/repos/extras/
# ls -l /var/www/html/repos/extras/Packages/
# ls -l /var/www/html/repos/updates/
# ls -l /var/www/html/repos/updates/Packages/

- create a new repodata for the local repositories by running the following commands, where the flag -g is used to update the package group information using the specified .xml file.

# createrepo -g comps.xml /var/www/html/repos/base/  
# createrepo -g comps.xml /var/www/html/repos/centosplus/	
# createrepo -g comps.xml /var/www/html/repos/extras/  
# createrepo -g comps.xml /var/www/html/repos/updates/  


- configure nginx to access the repos directories
    create a new config -  /etc/nginx/conf.d/repos.conf 

server {
        listen   80;
        server_name  tbserver-101;	#or your server IP if DNS not configured.
        root   /var/www/html/repos;
        location / {
                index  index.php index.html index.htm;
                autoindex on;	#enable listing of directory index
        }
}

- cronjob for scheduled sync
    create /etc/cron.daily/update-localrepos and add below commands.
#!/bin/bash
##specify all local repositories in a single variable
LOCAL_REPOS=”base centosplus extras updates”
##a loop to update repos one at a time 
for REPO in ${LOCAL_REPOS}; do
reposync -g -l -d -m --repoid=$REPO --newest-only --download-metadata --download_path=/var/www/html/repos/
createrepo -g comps.xml /var/www/html/repos/$REPO/  
done

- set permission for this
# chmod 755 /etc/cron.daily/update-localrepos

on local\client machine
===================
vim /etc/yum.repos.d/local-repos.repo

- add below

[local-base]
name=CentOS Base
baseurl=http://104.196.188.53/base/
gpgcheck=0
enabled=1

[local-centosplus]
name=CentOS CentOSPlus
baseurl=http://104.196.188.53/centosplus/
gpgcheck=0
enabled=1

[local-extras]
name=CentOS Extras
baseurl=http://104.196.188.53/extras/
gpgcheck=0
enabled=1

[local-updates]
name=CentOS Updates
baseurl=http://104.196.188.53/updates/
gpgcheck=0
enabled=1


========troubleshooting =================
- forbiddern error on client

http://104.196.188.53/base/repodata/repomd.xml: [Errno 14] HTTP Error 403 - Forbidden
Trying other mirror.


I found that nginx couldn’t read the repo folders. This is apparently an SELinux thing. The following commands resolved the issue:

# yum install -y policycoreutils-devel
# grep nginx /var/log/audit/audit.log | audit2allow -M nginx
# semodule -i nginx.pp


============ usig apache ===========================
vi /etc/httpd/conf.d/vhost.conf

NameVirtualHost *:80

<VirtualHost *:80>
    ServerAdmin webmaster@example.com
    ServerName 104.196.188.53
    ServerAlias 104.196.188.53
    DocumentRoot /var/www/html/repos/
    ErrorLog /var/log/httpd/error.log
    CustomLog /var/log/httpd/access.log combined
</VirtualHost>

https://www.digitalocean.com/community/tutorials/how-to-install-the-apache-web-server-on-centos-7

- comment out default content from /etc/httpd/conf.d/welcome.conf (to avoid ndefault landing page)
- enable directory list (Options Indexes FollowSymLinks) in /etc/apache2/apache2.conf (or relavent httpd file)



