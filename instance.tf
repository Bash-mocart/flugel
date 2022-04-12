# EC2 instance network interface placed in a subnet
resource "aws_network_interface" "eni" {
  subnet_id = aws_subnet.my_subnet.id


  tags = {
    Name = "primary_network_interface"
  }
}

resource "aws_network_interface" "eni2" {
  subnet_id = aws_subnet.my_subnet_b.id


  tags = {
    Name = "primary_network_interface"
  }
}

resource "aws_instance" "flugel_instance" {
 # us-east-1
  # instance_type = var.instance_type
  launch_template {
    id      = aws_launch_template.nginx_launch.id
    version = aws_launch_template.nginx_launch.latest_version
  }

  

  network_interface {
    network_interface_id = aws_network_interface.eni.id
    device_index         = 0
  }

  tags = {
    Name  = "Flugel"
    Owner = "InfraTeam"
  }
}

  resource "aws_instance" "flugel_instance2" {
   # us-east-1
  # instance_type = var.instance_type
 
  launch_template {
    id      = aws_launch_template.nginx_launch.id
    version = aws_launch_template.nginx_launch.latest_version
  }


  network_interface {
    network_interface_id = aws_network_interface.eni2.id
    device_index         = 0
  }

  tags = {
    Name  = "Flugel"
    Owner = "InfraTeam"
  }

}