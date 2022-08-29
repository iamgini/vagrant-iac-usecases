import os

import testinfra.utils.ansible_runner

testinfra_hosts = testinfra.utils.ansible_runner.AnsibleRunner(
    os.environ['MOLECULE_INVENTORY_FILE']
).get_hosts('all')


def test_hosts_file(host):
    f = host.file('/etc/hosts')

    assert f.exists
    assert f.user == 'root'
    assert f.group == 'root'

def test_nginx_is_installed(host):
    nginx = host.package("nginx")
    assert nginx.is_installed

def test_nginx_running_and_enabled(host):
    nginx = host.service("nginx")
    assert nginx.is_running
    assert nginx.is_enabled

def test_php_is_installed(host):
    php = host.package("php7.3-fpm")
    assert php.is_installed

def test_php_running_and_enabled(host):
    php = host.service("php7.3-fpm")
    assert php.is_running
    assert php.is_enabled

def test_curl_localhost(host):
    cmd = host.check_output("curl http://localhost/wp-admin/install.php")
    assert 'WordPress' in cmd


