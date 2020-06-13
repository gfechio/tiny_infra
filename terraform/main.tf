provider "aws" {
  version = ">= 2.38.0"
}

provider "http" {}

module "vpc" {
      source              = "./vpc"
}

module "network" {
      source              = "./network"
}

module "eks" {
      source              = "./eks"
      key_name            = "${var.key_name}"
}

module "ecr" {
      source              = "./ecr"
}

module "ec2" {
      source              = "./ec2"
}

module "k8s" { 
      source              = "./k8s"
}
