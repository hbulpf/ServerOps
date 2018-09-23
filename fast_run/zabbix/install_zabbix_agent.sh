#!/bin/bash

#install Zabbix source: http://repo.zabbix.com/zabbix/3.4/rhel/7/x86_64/
sudo rpm -ivh http://repo.zabbix.com/zabbix/3.4/rhel/7/x86_64/zabbix-release-3.4-2.el7.noarch.rpm 
#install Zabbix 
sudo yum -y install zabbix-agent

#set zabbix agent config
# vim /etc/zabbix/zabbix_agentd.conf
# Server=132.232.42.144                   #用于被动模式，数据获取
# ServerActive=132.232.42.144             #用于主动模式，数据提交
sudo sed -i 's/^Server=.*/Server=132.232.42.144/g' /etc/zabbix/zabbix_agentd.conf
sudo sed -i 's/^ServerActive=.*/ServerActive=132.232.42.144/' /etc/zabbix/zabbix_agentd.conf

sudo systemctl start zabbix-agent
sudo systemctl enable zabbix-agent

