output "subnet_id" {
  value = aws_subnet.my_subnet.id
}

output "subnet_b_id" {
  value = aws_subnet.my_subnet_b.id
}

output "vpc_id" {
  value = aws_vpc.my_vpc.id
}

output "sg_allow_8080" {
  value = aws_security_group.allow_8080.id
}
