provider "aws" {

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


module "flugel" {
  source                  = "../modules/flugel/"
  environment             = "production"
}

output "instance_tags" {
  value = module.flugel.instance_tag
}

output "s3_tags" {
  value = module.networking.s3_tag
}