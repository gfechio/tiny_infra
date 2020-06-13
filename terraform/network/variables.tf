variable "vpc_id" {}

variable "default_tag" {
  type    = string
  default = "backbase-assignment"
}

variable "cluster_name" {}

variable "region" {}

variable "availability_zones" {} 

variable "vpc_cidr" {}

variable "newbits" {}
