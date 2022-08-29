<p align="center">
  <img width="150" height="150" src="https://upload.wikimedia.org/wikipedia/commons/9/98/WordPress_blue_logo.svg">
</p>

# Ansible Role: WordPress
[![Build Status](https://travis-ci.org/MakarenaLabs/ansible-role-wordpress.svg?branch=master)](https://travis-ci.org/MakarenaLabs/ansible-role-wordpress)
[![License](https://img.shields.io/github/license/MakarenaLabs/ansible-role-wordpress.svg)](https://opensource.org/licenses/MIT)
[![Ansible Version](https://img.shields.io/badge/ansible-%3E%3D_1.4-8892BF.svg)](https://www.ansible.com/)
[![Ansible Role](https://img.shields.io/ansible/role/36472.svg)](https://galaxy.ansible.com/MakarenaLabs/wordpress/)
[![Ansible Quality](https://img.shields.io/ansible/quality/36472.svg)](https://galaxy.ansible.com/MakarenaLabs/wordpress/)
[![Ansible Downloads](https://img.shields.io/ansible/role/d/36472.svg)](https://galaxy.ansible.com/MakarenaLabs/wordpress/)

Ansible role that installs and configures WordPress with Nginx or Apache2.

Features include:
- Installation of any WordPress version to specified directory
- Configuration of `wp-config.php`
- Fetch random salts for wp-config.php (https://api.wordpress.org/secret-key/1.1/salt/)

## Installation

Using `ansible-galaxy`:
```shell
$ ansible-galaxy install makarenalabs.wordpress
```

Using `arm` ([Ansible Role Manager](https://github.com/mirskytech/ansible-role-manager/)):
```shell
$ arm install makarenalabs.wordpress
```

Using `git`:
```shell
$ git clone https://github.com/MakarenaLabs/ansible-role-wordpress.git
```

## Requirements & Dependencies
- Ansible 1.4 or higher
- Curl

## Variables
Here is a list of all the default variables for this role, which are also available in `defaults/main.yml`.

```yaml
wp_version: 5.0.3
wp_install_dir: '/var/www/html'
wp_db_name: "{{ wp_mysql_db }}"
wp_db_user: "{{ wp_mysql_user }}"
wp_db_password: "{{ wp_mysql_password }}"
wp_db_host: 'localhost'
wp_db_charset: 'utf8'
wp_db_collate: ''
wp_table_prefix: 'wp_'
wp_debug: false
wp_admin_email: 'admin@example.com'
wp_webserver: nginx
site_name: "{{ wp_sitename }}"
```
 - ```wp_mysql_db```
 - ```wp_mysql_user```
 - ```wp_mysql_password```
 - ```wp_sitename```

These variables are required!

Default webserver selected is ```nginx```. If you want to use ```apache2``` you have to set ```wp_webserver``` variable as follow:
```yaml
wp_webserver: apache
```

## Example playbook
```yaml
---
- hosts: all
  vars:
    wp_version: 5.0.3
    wp_mysql_db: 'database_name_here'
    wp_mysql_user: 'username_here'
    wp_mysql_password: 'password_here'
    wp_webserver: nginx
    wp_sitename: example.com
    wp_admin_email: 'your@email.com'
    wp_install_dir: "/var/www/{{ wp_sitename }}"
  roles:
    - makarenalabs.wordpress
```

## Testing
```shell
$ git clone https://github.com/MakarenaLabs/ansible-role-wordpress.git
$ cd ansible-role-wordpress
$ vagrant up
```

## License

Licensed under the MIT License. See the LICENSE file for details.

Copyright © 2019 [MakarenaLabs](https://www.makarenalabs.com)
