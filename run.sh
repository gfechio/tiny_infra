#!/bin/bash

source export.envvar

for i in {1..80} ; do echo -n "." ;  done ; echo
echo "Guaranteeing you have Docker and AWS CLI installed."
for i in {1..80} ; do echo -n "." ;  done ; echo

$(which packer 1> /dev/null )
if [ $? -gt 0 ] ; then
       packer_url=$(curl https://releases.hashicorp.com/index.json | jq '{packer}' | egrep "linux.*amd64" | sort --version-sort -r | head -1 | awk -F[\"] '{print $4}') #"
   fi
fi

$(which terraform 1> /dev/null )
if [ $? -gt 0 ] ; then
       terraform_url=$(curl https://releases.hashicorp.com/index.json | jq '{terraform}' | egrep "linux.*amd64" | sort --version-sort -r | head -1 | awk -F[\"] '{print $4}') #"
fi

$(which docker 1> /dev/null )
if [ $? -gt 0 ] ; then
  curl -fsSL https://get.docker.com | bash
fi

$(which aws 1> /dev/null )
if [ $? -gt 0 ] ; then
	curl "https://s3.amazonaws.com/aws-cli/awscli-bundle.zip" -o "awscli-bundle.zip"
	unzip awscli-bundle.zip
	sudo ./awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws
fi

for i in {1..80} ; do echo -n "." ;  done ; echo
echo "This script requires interaction"
for i in {1..80} ; do echo -n "." ;  done ; echo

for i in {1..80} ; do echo -n "." ;  done ; echo
echo "Generating ECR for docker image."
for i in {1..80} ; do echo -n "." ;  done ; echo

# DEPLOY INFRASTRUCURE EKS/ECR and EC2 

cd terraform

echo "Running terraform init..."
terraform init

echo "Running terraform plan..."
terraform plan

echo "Running terraform apply..."
terraform apply



# RUN PACKER BUILD FOR CENTOS AND DOCKER IMAGE W/ TOMCAT
cd packer/

echo "Running build for AMI Image with Centos. To ensure Centos AMI wiht curl."
$(which packer) build -var-file=variables.json centos.json

echo "Running build for docker image tomcat"
$(which packer) build -var-file=variables.json docker-tomcat.json




# DEPLOY CONTAIRNIZED SERVICE WITH TERRAFORM
cd k8s/terraform

echo "Running terraform init..."
terraform init

echo "Running terraform plan..."
terraform plan

echo "Running terraform apply..."
terraform apply

cd -
