#!/bin/bash

_apt_opts="sudo DEBIAN_FRONTEND=noninteractive apt-get -y -o Dpkg::Options::=--force-confdef -o Dpkg::Options::=--force-confold"
_apt_install_cmd="${_apt_opts} install"
_apt_upgrade_cmd="${_apt_opts} dist-upgrade"

ssh_auth_key_file="/root/.ssh/authorized_keys"
ssh_root_pubkey="ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCi6UIVruH0CfKewYlSjA7oR6gjahZrkJ+k/0cj46nvYrORVcds2cijZPT34ACWkvXV8oYvXGWmvlGXV5H1sD0356zpjhRnGo6j4UZVS6KYX5HwObdZ6H/i+A9knEyXxOCyo6p4VeJIYGhVYcQT4GDAkxb8WXHVP0Ax/kUqrKx0a2tK9JjGkuLbufQc3yWhqcfZSVRU2a+M8f8EUmGLOc2VEi2mGoxVgikrelJ0uIGjLn63L6trrsbvasoBuILeXOAO1xICwtYFek/MexQ179NKqQ1Wx/+9Yx4Xc63MB0vR7kde6wxx2Auzp7CjJBFcSTz0TXSRsvF3mnUUoUrclNkr voa@shalb.com"

# deploy configs (preinstall)
sudo chown -R root:root /tmp/configs_preinstall
sudo rsync -av /tmp/configs_preinstall/ /

# add ssh pubkey for root user
sudo sed -i "\$a${ssh_root_pubkey}" "${ssh_auth_key_file}"

# upgrade all packages
sudo apt-get update
${_apt_upgrade_cmd}

# install additional soft
${_apt_install_cmd} htop atop mtr sysstat tcptraceroute nload unzip iotop apt-file unzip mysql-client

# Ntp
${_apt_install_cmd} ntp
sudo systemctl enable ntp
sudo systemctl start ntp

# Postfix
echo "postfix postfix/mailname string example.com" | sudo debconf-set-selections
echo "postfix postfix/main_mailer_type string 'Internet Site'" | sudo debconf-set-selections
${_apt_install_cmd} postfix mailutils mutt

# Oracle Java
sudo apt-add-repository -y ppa:webupd8team/java
sudo apt-get update
echo 'oracle-java8-installer shared/accepted-oracle-license-v1-1 select true' | sudo /usr/bin/debconf-set-selections
${_apt_install_cmd} oracle-java8-installer

# Tomcat
#${_apt_install_cmd} tomcat8 haveged
#sudo rm -rf /var/lib/tomcat8/webapps/ROOT/

# clear logs
sudo rm -rf /var/log/*/*
# Apache2
#${_apt_install_cmd} apache2

# Install Play Framework
cd /opt
sudo wget https://downloads.typesafe.com/play/1.5.0/play-1.5.0.zip
sudo unzip play-1.5.0.zip
sudo ln -s /opt/play-1.5.0/play /usr/local/bin/play

# deploy configs (post-install)
sudo chown -R root:root /tmp/configs
sudo rsync -av /tmp/configs/ /
sudo chown -R ubuntu:ubuntu /home/ubuntu
