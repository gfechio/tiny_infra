#!/bin/bash

function terraform_eks() {
	# DEPLOY INFRASTRUCURE EKS/ECR and EC2
	cd terraform
	echo "Running terraform init..."
	terraform init
	echo "Running terraform plan..."
	terraform plan
	echo "Running terraform apply..."
	terraform apply
	cd ..
}

source .aws_export.env

for i in {1..80} ; do echo -n "." ;  done ; echo
echo "Guaranteeing you have Docker and AWS CLI installed."
for i in {1..80} ; do echo -n "." ;  done ; echo

$(which packer 1> /dev/null )
if [ $? -gt 0 ] ; then
       packer_url=$(curl https://releases.hashicorp.com/index.json | jq '{packer}' | egrep "linux.*amd64" | sort --version-sort -r | head -1 | cut -d\" -f4)
       wget $packer_url -O ~/ ; unzip ~/packer_*.zip ; chmod +x ~/packer ; mv ~/packer /usr/local/bin/
fi

$(which terraform 1> /dev/null )
if [ $? -gt 0 ] ; then
       terraform_url=$(curl https://releases.hashicorp.com/index.json | jq '{terraform}' | egrep "linux.*amd64" | sort --version-sort -r | head -1 | cut -d\" -f4)
       wget $terraform_url -O ~/ ; unzip ~/terraform_*.zip ; chmod +x ~/terraform ; mv ~/terraform /usr/local/bin/
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
read -r -p "Create Centos AMI? [Y/n] " input
case $input in
    [yY][eE][sS]|[yY])
		cd packer/
		$(which packer) build -var-file=variables.json centos.json
		cd ..
		;;
    [nN][oO]|[nN])
		echo "Continuing..."
       		;;
    *)
	echo "Invalid input"
	exit 1
	;;
esac

for i in {1..80} ; do echo -n "." ;  done ; echo
read -r -p "Create Docker Image for tomcat? [Y/n] " input
case $input in
    [yY][eE][sS]|[yY])
		docker build -t $account_id.dkr.ecr.$region.amazonaws.com/tomcat_project .
		docker push  $account_id.dkr.ecr.$region.amazonaws.com/tomcat_project
		;;
    [nN][oO]|[nN])
		echo "Continuing..."
       		;;
    *)
	echo "Invalid input"
	exit 1
	;;
esac

echo "Now you can apply terraform infra."
