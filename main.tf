terraform {
  required_version = ">= 1.14.3"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.28.0"
    }
    # random = {
    #   source  = "hashicorp/random"
    #   version = "3.7.2"
    # }
  }
  cloud {
    organization = "cloud-infra-dev123"
    workspaces {
      name    = "testing-terraform-aws-modules" # Workspace with VCS driven workflow
      project = "AWS-Cloud-IaC"
    }
  }
}


provider "aws" {
  region = "us-east-1"
  # allowed_account_ids = ["211125325120"]
}

module "vpc" {
  source = "./vpc"

  name     = "ramesh-vpc"
  vpc_cidr = "10.0.0.0/16"

  azs              = ["us-east-1a", "us-east-1b", "us-east-1c"]
  public_subnets   = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  private_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
  database_subnets = ["10.0.201.0/24", "10.0.202.0/24", "10.0.203.0/24"]

  enable_nat_gateway = true

  tags = {
    Terraform   = "true"
    Environment = "dev"
    tags_owner = "ramesh"
  }
}


# terraform {
#   #required_version = ">= 1.0" # which means any version equal & above 0.14 like 0.15, 0.16 etc and < 1.xx
#   required_version = ">= 1.14.3"   
#   required_providers {
#     aws = {
#       source  = "hashicorp/aws"
#       #version = ">= 4.65"
#       version = ">= 6.28.0"
#       # region = var.aws_region
#     }
#   }
#     backend "s3" {
#       bucket = "gavprofileactions25"
#       key    = "vpc/terraform.tfstate"
#       region = "us-east-1"
#     }

#   }


# # Provider Block
# provider "aws" {
#   region = var.aws_region
#   # allowed_account_ids = [ "779563210855" ]

#   #   assume_role {
#   #   role_arn     = "arn:aws:iam::779563210855:role/terraform-admin-role"
#   #   session_name = "terraform-session"
    
#   # }
# }
