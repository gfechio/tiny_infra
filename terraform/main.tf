provider "aws" {
  version   = ">= 2.38.0"
  region    = var.aws_region
}

provider "http" {}

module "vpc" {
      source              = "./vpc"
}

module "network" {
      source              = "./network"
      vpc_id              = module.vpc.aws_vpc_id
      region              = var.aws_region
      availability_zones  = local.availability_zones
      vpc_cidr            = var.vpc_cidr
      newbits             = var.newbits
      cluster_name        = var.cluster_name
}

module "eks" {
      source              = "./eks"
      vpc_id              = module.vpc.aws_vpc_id
      private_subnet_ids  = module.network.private_subnet_ids
      cluster_name        = var.cluster_name
}

module "ecr" {
      source              = "./ecr"
}

module "ec2" {
      source              = "./ec2"
      vpc_id              = module.vpc.aws_vpc_id
      public_subnet_ids   = module.network.public_subnet_ids
}

module "app" {
      source              = "./app"
      region              = var.aws_region
      availability_zones  = local.availability_zones
      vpc_id              = module.vpc.aws_vpc_id
      ecr_url             = module.ecr.ecr_url
}

