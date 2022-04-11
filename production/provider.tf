# aws credentials set up in terraform workspace env variables
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
      name = "flugel"
    }
  }
}

module "vpc" {
  source   = "../modules/vpc/"
  vpc_name = "vpc"
}

module "eks" {
  source = "../modules/eks/"
}