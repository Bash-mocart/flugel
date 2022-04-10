resource "aws_network_interface" "eni" {
  subnet_id = aws_subnet.my_subnet.id

  tags = {
    Name = "primary_network_interface"
  }
}


resource "aws_instance" "flugel_instance" {
  ami           = var.ami # us-east-1
  instance_type = var.instance_type

  network_interface {
    network_interface_id = aws_network_interface.eni.id
    device_index         = 0
  }

  tags = {
    Name  = "Flugel"
    Owner = "InfraTeam"
  }

}