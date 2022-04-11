variable "vpc_module_source" {
  default = "root/flugel/modules/vpc"
}


variable "eks_cluster" {
  type    = string
  default = "flugel"

}

variable "eks_version" {
  type    = string
  default = "1.20"
}

variable "eks_ami_type" {
  type    = string
  default = "AL2_x86_64"
}

variable "eks_capacity_type" {
  type    = string
  default = "ON_DEMAND"
}

variable "key_name" {
  type    = string
  default = "bashir"
}


variable "eks_iam_policy_attachment" {
  type    = string
  default = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}

variable "eks_iam_cni_policy" {
  type    = string
  default = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}

variable "amazon_ec2_container_registry_read_only" {
  type    = string
  default = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}
variable "eks_node_role" {
  type    = string
  default = "flugel_node_role"
}

variable "eks_node_group_name" {
  type    = string
  default = "node-general"
}

