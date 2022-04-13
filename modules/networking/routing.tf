resource "aws_route_table" "public" {
  # The VPC ID.
  vpc_id = aws_vpc.my_vpc.id

  route {
    # The CIDR block of the route.
    cidr_block = "0.0.0.0/0"

    # Identifier of a VPC internet gateway or a virtual private gateway.
    gateway_id = aws_internet_gateway.igw.id
  }

  # A map of tags to assign to the resource.
  tags = {
    Name = "public-${var.environment}"
  }
}

resource "aws_route_table_association" "public1" {
  # The subnet ID to create an association.
  subnet_id = aws_subnet.my_subnet.id

  # The ID of the routing table to associate with.
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public2" {
  # The subnet ID to create an association.
  subnet_id = aws_subnet.my_subnet_b.id

  # The ID of the routing table to associate with.
  route_table_id = aws_route_table.public.id
}
