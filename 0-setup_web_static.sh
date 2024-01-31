#!/usr/bin/env bash
# prepare your web servers

# install nginx if it's not installed
sudo apt-get -y update
sudo apt-get -y install nginx

# create folders if they don't already exist
sudo mkdir -p /data/web_static/releases/test/
sudo mkdir -p /data/web_static/shared/

# create fake html file
echo "Hello World!" > /data/web_static/releases/test/index.html

# create symbolic link
sudo ln -sf /data/web_static/releases/test/ /data/web_static/current

# change ownership of data folder
sudo chown -R ubuntu:ubuntu /data

# update nginx config
printf %s "server {
    listen 80 default_server;
    listen [::]:80 default_server;
    add_header X-Served-By $HOSTNAME;
    root   /var/www/html;
    index  index.html index.htm;

    location /hbnb_static {
    alias /data/web_static/current;
    index index.html index.htm;
    }

    location /redirect_me {
    return 301 http://google.com/;
    }

    error_page 404 /404.html;
    location /404 {
      root /var/www/html;
      internal;
    }
}" > /etc/nginx/sites-available/default

sudo service nginx restart
