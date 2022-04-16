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


# autoscaling module containing launch template, autoscaling group, autoscaling group attachment to the alb
module "autoscaling" {
  source                  = "../modules/autoscaling/"
  environment             = "production"
  subnet_id               = module.networking.subnet_id
  subnet_b_id             = module.networking.subnet_b_id
  aws_lb_target_group_arn = module.loadbalancer.alb-target_group_arn
  sg_allow_8080           = module.networking.sg_allow_8080
}
# load balancer  module containing alb, alb listener, alb listener rule, target group
module "loadbalancer" {
  source        = "../modules/loadbalancer/"
  environment   = "production"
  sg_allow_8080 = module.networking.sg_allow_8080
  subnet_id     = module.networking.subnet_id
  subnet_b_id   = module.networking.subnet_b_id
  vpc_id        = module.networking.vpc_id

}
# networking module containing vpc, 2 public subnets, s3 bucket, security groups, routing tables, internet gateway
module "networking" {
  source      = "../modules/networking/"
  environment = "production"

}
# outputting alb dns hostname 
output "alb_dns" {
  value = module.loadbalancer.alb-dns
}
# outputting instances_tags
output "instances_tags" {
  value = module.autoscaling.instances_tags
