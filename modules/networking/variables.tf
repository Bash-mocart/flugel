variable "vpc_cidr_block" {
  type    = string
  default = "10.0.0.0/16"
}
variable "public_subnet_cidr_block" {
  type    = string
  default = "10.0.1.0/24"
}

variable "public_subnet_b_cidr_block" {
  type    = string
  default = "10.0.2.0/24"
}

variable "s3_bucket" {
  type    = string
  default = "bashox1234567890"
}

variable "environment" {
  type    = string
}

