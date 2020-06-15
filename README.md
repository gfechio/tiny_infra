# Backbase
Backbase assignment project.

![Diagram](backbase.png)

## Understandment

- Create an scalabe Kubernetes deploy of a given tomcat. Setup ingress and autoscale.
- Create an EC2 instance using terraform, the EC2 must be able to query Google, using curl.


# Disclaimer

This project was built using the following versions:
- Packer v1.6.0
- Terraform v0.12.16
- Kubectl v1.18.2
- EKS v1.16.8-eks-e16311
- Docker 19.03.11

# Execution Plan

- Generate an K8S cluster to deploy the tomcat application.
- Deploy Tomcat 8 app using provided resources.
- Create ingress for tomcat service.
- Open application to be queried externally ( this will also include VPC changes to allow ingress connection). Use Port 8080
- Scale solution accordingly - [here](https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale-walkthrough/)
- Use multiple AZs

# Getting Started

- Have [jq](https://stedolan.github.io/jq/) installed.

- Export you credentials for AWS:

	Ex:
	`aws configure`

- Create Key Pair:

	`aws ec2 create-key-pair --key-name backbase | echo "$(jq -r .KeyMaterial)" > ~/.ssh/backbase.pem`
	`cmod 400 ~/.ssh/backbase.pem`

- Create a environment var file:

``` bash
cat > aws_export.env <<EOF
export access_key="<YOUR_ACCESS_KEY>"
export secret_key="<YOUR_SECRET_KEY>"
export private_key="~/.ssh/backbase.pem"
EOF
```
- Define AWS policies for you user, following docs in [here](aws/policy/README.md)

- To generate your Kubeconfig :

```
export KUBECONFIG=/my/dir/config
aws eks --region region-code update-kubeconfig --name cluster_name
```

Executing `run.sh` the following should happen:
- Download and install AWS cli/ Docker / packer / terraform
- Create a ECR repo named `tomcat_backbase` for EKS use.
- Deploy an EKS cluster to test tomcat K8S config.
- Generate and AMI and upload it to AWS to later use.
	"Most of AWS default AMIs already has curl installed, but packer process is making sure this is true"
- Instantiate EC2 on public subnet to access google and have backbase.pem to be accesible by SSH with ingress and egress rules.
- Generate a docker image fetching **sample.war** from Backbase givne URL and adding it to the container under **$CATALINA_HOME**.


# Tomcat non-Terraform in EKS

To deploy Tomcat K8S service not using the provided EKS follow this.
- `cd k8s` *where you can see the k8s yaml config*
- `deploy.sh` * applying the config step by step on the available K8S on you current config

# Improvements ( To Do )

- At the moment Packer is handling the build of images `in loco` since **AWS Image Builder** needs to be supported as Terraform provider.
  https://github.com/terraform-providers/terraform-provider-aws/issues/11084
- For this project it wasn't deployed any sidecars for aplication logging.
- Implement canary/(blue/green) deployment.
