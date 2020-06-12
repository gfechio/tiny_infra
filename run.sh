#!/bin/bash

source export.envvar

$(which docker 1> /dev/null )
if [ $? -gt 0 ] ; then
  curl -fsSL https://get.docker.com | bash
fi

echo $(pwd)

echo "Pulling hashicorp image"
docker pull hashicorp/packer

echo "Running build for docker image tomcat"
docker run hashicorp/packer build packer/docker-tomcat.json

echo "Running build for AMI Image with Centos7"
docker run hashicorp/packer build packer/centos7.json


