
resource "aws_instance" "flugel_instance" {
  ami           = var.ami # us-east-1
  instance_type = var.instance_type

  tags = {
    Name  = "Flugel"
    Owner = "InfraTeam"
  }

}