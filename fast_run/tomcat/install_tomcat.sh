#!/bin/bash
yum -y install tomcat tomcat-webapps tomcat-admin-webapps tomcat-docs-webapp tomcat-javadoc
systemctl start tomcat
systemctl enable tomcat