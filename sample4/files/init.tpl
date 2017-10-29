#!/bin/bash
hostname ${instancehostname} && hostname > /etc/hostname
echo "127.0.0.1 localhost `hostname`" > /etc/hosts
cd /home/ubuntu
git clone https://bitbucket.org/bohdaq/wisehands.me.git
cd /home/ubuntu/wisehands.me/ && play deps
mkdir -p /home/ubuntu/wisehands.me/modules/guice-1.2
cd /home/ubuntu/wisehands.me/modules/guice-1.2
wget https://www.playframework.com/modules/guice-1.2.zip
unzip guice-1.2.zip
sed -i 's/mysql-database-endpoint/${dbendpoint}/g' /home/ubuntu/wisehands.me/conf/application.conf
cd /home/ubuntu/wisehands.me/ && play run

