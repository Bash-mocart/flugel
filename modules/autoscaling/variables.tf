variable "key_name" {
  type    = string
  default = "jen"
}

variable "ami" {
  type    = string
  default = "ami-04505e74c0741db8d"
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "environment" {
  type    = string
}

variable "subnet_id" {
    type = string
  
}

variable "subnet_b_id" {
    type = string
  
}

variable "aws_lb_target_group_arn" {
    type = string
  
}

variable "sg_allow_8080" {
    type = string
  
}


