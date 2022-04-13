resource "aws_vpc" "my_vpc" {
  cidr_block = var.vpc_cidr_block


  # Makes your instances shared on the host.
  instance_tenancy = "default"

  #  Enable/disable DNS support in the VPC.
  enable_dns_support = true

  # . Enable/disable DNS hostnames in the VPC.
  enable_dns_hostnames = true


  tags = {
    Name = "vpc-${var.environment}"
  }
}

resource "aws_subnet" "my_subnet" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = var.public_subnet_cidr_block
  availability_zone = "us-east-1a"

  # Required for EKS. Instances launched into the subnet should be assigned a public IP address.
  map_public_ip_on_launch = true

  # A map of tags to assign to the resource.
  tags = {
    Name                           = "public-us-east-1a${var.environment}"
  }
}


resource "aws_subnet" "my_subnet_b" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = var.public_subnet_b_cidr_block
  availability_zone = "us-east-1b"

  # Required for EKS. Instances launched into the subnet should be assigned a public IP address.
  map_public_ip_on_launch = true

  # A map of tags to assign to the resource.
  tags = {
    Name                           = "public-us-east-1b-${var.environment}"
  }
}
resource "aws_internet_gateway" "igw" {
  # The VPC ID to create in.
  vpc_id = aws_vpc.my_vpc.id

  # A map of tags to assign to the resource.
  tags = {
    Name = "igw-${var.environment}"
  }
}





