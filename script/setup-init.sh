#!/bin/bash

set -euo pipefail

# update all
sudo yum update -y

# disable SELinux
sudo setenforce 0
sudo sed -i -e "s/^SELINUX=enforcing/SELINUX=disabled/g" /etc/selinux/config

# disable firewalld
sudo systemctl stop firewalld
sudo systemctl disable firewalld

# minimum packages
sudo yum install -y epel-release
sudo yum install -y @development
