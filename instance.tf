resource "aws_network_interface" "instance_network_attach" {
  subnet_id = aws_subnet.public.id

  tags = {
    Name = "primary_network_interface"
  }
}

resource "aws_instance" "flugel_instance" {
  ami           = "ami-04505e74c0741db8d" # us-east-1
  instance_type = "t2.micro"

  network_interface {
    network_interface_id = aws_network_interface.instance_network_attach.id
    device_index         = 0
  }

  tags = {
    Name  = "Flugel"
    Owner = "InfraTeam"
  }

}