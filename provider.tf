provider "aws" {
  region  = "us-east-1"

}


terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.4.0"
    }
  }

  backend "remote" {
#          The name of your Terraform Cloud organization.
        organization = "flugel"
#
#         # The name of the Terraform Cloud workspace to store Terraform state files in.
        workspaces {
           name = "flugel-infra"
         }
       }
}