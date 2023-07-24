provider "aws" {
  region = "us-east-2"
}

data "aws_availability_zones" "available" {}

locals {
  name = "p41-aayush-vpc"

  vpc_cidr = "10.9.0.0/16"
  azs      = slice(data.aws_availability_zones.available.names, 0, 2)

  tags = {
    interviwee = local.name
    terraform  = "true"
  }
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = local.name
  cidr = local.vpc_cidr

  azs                           = local.azs
  private_subnets               = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 8, k)]
  public_subnets                = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 8, k + 4)]
  private_subnet_names          = ["Private Subnet One", "Private Subnet Two"]
  manage_default_network_acl    = true
  manage_default_route_table    = true
  manage_default_security_group = true
  enable_dns_hostnames          = true
  enable_dns_support            = true
  enable_nat_gateway            = true
  single_nat_gateway            = true
  tags                          = local.tags
}
