# allows 8080 inbound traffic 
resource "aws_security_group" "allow_8080" {
  name        = "allow-8080-${var.environment}"
  description = "Allow inbound traffic on port 8080"
  vpc_id      = aws_vpc.my_vpc.id

  tags = {
    Name = "security group instance"
  }
}



resource "aws_security_group_rule" "allow_inbound_8080" {
  description              = "Allow port 8080"
  from_port                = 8080
  protocol                 =  "tcp"
  security_group_id        = aws_security_group.allow_8080.id
  cidr_blocks              = ["0.0.0.0/0"]
  
  to_port                  = 8080
  type                     = "ingress"
}
# outbound traffic
resource "aws_security_group_rule" "outgoing" {
  description              = "Allow all outgoing"
  from_port                = 0
  protocol                 = "-1"
  security_group_id        = aws_security_group.allow_8080.id
  cidr_blocks              = ["0.0.0.0/0"]
  to_port                  = 0
  type                     = "egress"
}