#!/bin/bash

## customizações de terminal e log
apt install wget vim atop htop nmap whowatch mtr htop rsync acl locate ethtool screen lshw hdparm ttyrec tcpdump auditd sudo openssh-server libsox-fmt-base dialog unzip autoconf -y

## editar permição de acesso root SSH
nano /etc/ssh/sshd_config

read -p "Editado permição de acesso root SSH, Enter para continuar..."

## resetar ssh
sudo service ssh restart
echo "Restart no ssh"
