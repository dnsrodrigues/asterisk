#!/bin/bash
# convert.sh

set -e

YUM_PACKAGE_NAME="sox"
DEB_PACKAGE_NAME="sox"

 if cat /etc/*release | grep ^NAME | grep CentOS; then
    echo "==============================================="
    echo "Installing packages $YUM_PACKAGE_NAME on CentOS"
    echo "==============================================="
    dnf install -y $YUM_PACKAGE_NAME
 elif cat /etc/*release | grep ^NAME | grep Red; then
    echo "==============================================="
    echo "Installing packages $YUM_PACKAGE_NAME on RedHat"
    echo "==============================================="
    dnf install -y $YUM_PACKAGE_NAME
 elif cat /etc/*release | grep ^NAME | grep Rocky; then
    echo "==============================================="
    echo "Installing packages $YUM_PACKAGE_NAME on Rocky Linux"
    echo "==============================================="
    dnf install -y $YUM_PACKAGE_NAME
  elif cat /etc/*release | grep ^NAME | grep Alma; then
    echo "==============================================="
    echo "Installing packages $YUM_PACKAGE_NAME on Alma Linux"
    echo "==============================================="
    dnf install -y $YUM_PACKAGE_NAME
 elif cat /etc/*release | grep ^NAME | grep Fedora; then
    echo "================================================"
    echo "Installing packages $YUM_PACKAGE_NAME on Fedora"
    echo "================================================"
    dnf install -y $YUM_PACKAGE_NAME
 elif cat /etc/*release | grep ^NAME | grep Ubuntu; then
    echo "==============================================="
    echo "Installing packages $DEB_PACKAGE_NAME on Ubuntu"
    echo "==============================================="
    apt update
    apt install -y $DEB_PACKAGE_NAME
 elif cat /etc/*release | grep ^NAME | grep Debian ; then
    echo "==============================================="
    echo "Installing packages $DEB_PACKAGE_NAME on Debian"
    echo "==============================================="
    apt update
    apt install -y $DEB_PACKAGE_NAME
 elif cat /etc/*release | grep ^NAME | grep Mint ; then
    echo "============================================="
    echo "Installing packages $DEB_PACKAGE_NAME on Mint"
    echo "============================================="
    apt update
    apt install -y $DEB_PACKAGE_NAME
 else
    echo "OS NOT DETECTED, couldn't install package $PACKAGE"
    exit 1;
 fi
 
echo "============================================="
echo "Converting audios to GSM, ALAW and ULAW"
echo "============================================="

for a in $(find . -name '*.sln16'); do
  sox -t raw -e signed-integer -b 16 -c 1 -r 16k $a -t gsm -r 8k `echo $a|sed "s/.sln16/.gsm/"`;
  sox -t raw -e signed-integer -b 16 -c 1 -r 16k $a -t raw -r 8k -e a-law `echo $a|sed "s/.sln16/.alaw/"`;
  sox -t raw -e signed-integer -b 16 -c 1 -r 16k $a -t raw -r 8k -e mu-law `echo $a|sed "s/.sln16/.ulaw/"`;

done