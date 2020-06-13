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

