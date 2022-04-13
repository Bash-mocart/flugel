# aws credentials set up in terraform workspace env variables
provider "aws" {

}

locals {
  env = terraform.workspace

  disk_size_gb = {
    dev  = 50
    prod = 100
  }

  machine_type = {
    dev  = "e2-standard-2"
    prod = "e2-medium"
  }
...
}


terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.4.0"
    }
  }
  # using terraform cloud as backend 
  backend "remote" {
    #          The name of your Terraform Cloud organization.
    organization = "flugel-infra"
    #
    #         # The name of the Terraform Cloud workspace to store Terraform state files in.
    workspaces {
      name = "flugel-staging-ec2"
    }
  }
}