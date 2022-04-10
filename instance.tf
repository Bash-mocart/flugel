resource "aws_network_interface" "instance_network_attach" {
  subnet_id = aws_subnet.public.id

  tags = {
    Name = "primary_network_interface"
  }
}

resource "aws_instance" "flugel_instance" {
  ami           = var.ami # us-east-1
  instance_type = var.instance_type

  network_interface {
    network_interface_id = aws_network_interface.instance_network_attach.id
    device_index         = 0
  }

  tags = {
    Name  = "Flugel"
    Owner = "InfraTeam"
  }

}