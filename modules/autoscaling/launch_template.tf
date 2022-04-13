# Launch template for the autoscaling group
resource "aws_launch_template" "nginx_launch" {
  name = "nginx-${var.environment}"

  instance_type = var.instance_type
  key_name = var.key_name
  image_id           = var.ami
  

  vpc_security_group_ids = [var.sg_allow_8080]


  user_data = filebase64("${path.module}/script.sh")
}