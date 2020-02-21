#!/bin/bash

wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo             #导入jenkins源
rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key                    #导入官方jenkins证书