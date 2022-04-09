resource "aws_subnet" "public" {
  # The VPC ID.
  vpc_id = aws_vpc.main.id

  # The CIDR block for the subnet.
  cidr_block = var.public_subnet_cidr_block

  # The AZ for the subnet.
  availability_zone = "us-east-1a"

  # Required for EKS. Instances launched into the subnet should be assigned a public IP address.
  map_public_ip_on_launch = true

  # A map of tags to assign to the resource.
  tags = {
    Name = "Public subnet"
  }
}