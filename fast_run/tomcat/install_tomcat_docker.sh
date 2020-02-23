#!/bin/bash
docker pull tomcat:8.5.51-jdk8-adoptopenjdk-hotspot
docker run --name tomcat -d -p 8080:8080 \ 
    --restart=always
    -v /data/tomcat:/usr/local/tomcat  
    tomcat  