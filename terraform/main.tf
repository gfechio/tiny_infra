module "vpc" {
      region                                 = "${var.aws_region}"
      name                                   = "vpc"
      source                                 = "./modules"
      cluster_name                           = "${var.eks-cluster-name}"
}

module "network" {
      source                                 = "./modules"
}

module "policy" {
      source                                 = "./modules"
}

module "sec-group" {
      source                                 = "./modules"
      vpc_id                                 = "${module.vpc.vpc_id}"
}

module "eks" {
      source                                 = "./modules"
      subnets                                = "${module.vpc.subnets}"
      security_group_eks_master_id           = "${module.sg.security_group_eks_master_id}"
      sg_workers_id                          = "${module.sg.sg_workers_id}"
      role_arn                               = "${module.policy.role_arn}"
      role_name                              = "${module.policy.role_name}"
      instance_profile_name                  = "${module.policy.instance_profile_name}"
      cluster_name                           = "${var.eks-cluster-name}"
      region                                 = "${var.aws_region}"
      key_name                               = "${var.key_name}"
}

module "ecr" {
      source                                 = "./modules"
}

module "ec2" {
      source                                 = "./modules"
}
