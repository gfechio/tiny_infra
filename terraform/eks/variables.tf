data "aws_region" "current" {}
data "aws_availability_zones" "available" {}

variable "key_name" {
   default = "backbase-key"
}

variable "eks_cluster_name" {
  description = "EKS Backbase Assignment"
  type        = string
  default     = "eks-backbase"
}

variable "cluster_name" {}

variable "vpc_id" {}

variable "private_subnet_ids" { type = list }