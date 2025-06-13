#!/usr/bin/env bash

cd /vagrant
tar zxvf nginx-1.15.0.tar.gz
cd nginx-1.15.0/
ll
./configure --without-http_rewrite_module --without-http_gzip_module
make
sudo make install
sudo /usr/local/nginx/sbin/nginx