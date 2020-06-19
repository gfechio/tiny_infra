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

function terraform_k8s() {
	# DEPLOY CONTAIRNIZED SERVICE WITH TERRAFORM
    aws eks --region eu-central-1 update-kubeconfig --name eks
	cd k8s/terraform
    sed -i -e "s/ACCOUNT_ID/$account_id/g" app_deployment.tf
	aws ec2 describe-vpcs --filters "Name=tag:Name, Values=project-assignment" | jq .Vpcs[0].VpcId
	sed -i 's/NEW-VPC-ID/<information from last command>/' alb-ingress-controller.yaml
	echo "Running terraform init..."
	terraform init
	echo "Running terraform plan..."
	terraform plan
	echo "Running terraform apply..."
	terraform apply
	cd -
}

source .aws_export.env

for i in {1..80} ; do echo -n "." ;  done ; echo
echo "Guaranteeing you have Docker and AWS CLI installed."
for i in {1..80} ; do echo -n "." ;  done ; echo

$(which packer 1> /dev/null )
if [ $? -gt 0 ] ; then
       packer_url=$(curl https://releases.hashicorp.com/index.json | jq '{packer}' | egrep "linux.*amd64" | sort --version-sort -r | head -1 | awk -F[\"] '{print $4}') #"
       wget $packer_url -O ~/ ; unzip ~/packer_*.zip ; chmod +x ~/packer ; mv ~/packer /usr/local/bin/
fi

$(which terraform 1> /dev/null )
if [ $? -gt 0 ] ; then
       terraform_url=$(curl https://releases.hashicorp.com/index.json | jq '{terraform}' | egrep "linux.*amd64" | sort --version-sort -r | head -1 | awk -F[\"] '{print $4}') #"
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
read -r -p "Deploy Terraform EKS/EC2/ECR Infra? [Y/n] " input
case $input in
    [yY][eE][sS]|[yY])
		terraform_eks
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
		docker build -t $account_id.dkr.ecr.eu-central-1.amazonaws.com/tomcat_project .
		docker push  $account_id.dkr.ecr.eu-central-1.amazonaws.com/tomcat_project
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
read -r -p "Deploy Terraform K8S services? [Y/n] " input
case $input in
    [yY][eE][sS]|[yY])
		terraform_k8s
		;;
    [nN][oO]|[nN])
		echo "You can run the configs using ./k8s/deploy.sh"
       		;;
    *)
	echo "Invalid input"
	exit 1
	;;
esac

