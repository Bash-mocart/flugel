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
