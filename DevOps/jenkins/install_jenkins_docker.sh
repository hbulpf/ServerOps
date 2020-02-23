#!/bin/bash
docker run \
  --restart=always \
  --name=jenkins8081 \
  -u root \
  -d \
  -p 8081:8080 \
  -v /data/jenkins/jenkins_home:/var/jenkins_home \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v /jenkins/user_home:/home \
  jenkinsci/blueocean