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
    
    #         # The name of the Terraform Cloud workspace to store Terraform state files in.
    workspaces {
      name = "flugel"
    }
  }
}


module "autoscaling" {
  source                  = "../modules/autoscaling/"
  environment             = "staging"
  subnet_id               = module.networking.subnet_id
  subnet_b_id             = module.networking.subnet_b_id
  aws_lb_target_group_arn = module.loadbalancer.alb-target_group_arn
  sg_allow_8080           = module.networking.sg_allow_8080
}

module "loadbalancer" {
  source        = "../modules/loadbalancer/"
  environment   = "staging"
  sg_allow_8080 = module.networking.sg_allow_8080
  subnet_id     = module.networking.subnet_id
  subnet_b_id   = module.networking.subnet_b_id
  vpc_id        = module.networking.vpc_id

}

module "networking" {
  source      = "../modules/networking/"
  environment = "staging"

}

output "alb_dns" {
  value = module.loadbalancer.alb-dns
}