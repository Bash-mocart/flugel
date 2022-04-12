resource "aws_lb" "test" {
  name               = "flugel-nginx-alb"
  internal           = false
  load_balancer_type = "application"
#   security_groups    = [aws_security_group.lb_sg.id]
  subnets            = [
      aws_subnet.my_subnet.id,
      aws_subnet.my_subnet_b.id
  ]

  enable_deletion_protection = false


  tags = {
    Environment = "production"
  }
}

# resource "aws_lb_listener_rule" "nginx_routing" {
#   listener_arn = "${aws_lb_listener.nginx.arn}"
#   priority     = 99

#   action {
#     type             = "forward"
#     target_group_arn = "${aws_lb_target_group.instance_target.arn}"
#   }

#   condition {
#     field  = "host-header"
#     values = ["my-service.*.terraform.io"]
#   }
# }

resource "aws_lb_listener" "alb-listener-80" {
  load_balancer_arn = aws_lb.test.arn
  port              = "8080"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.instance_target.arn
  }
}

resource "aws_lb_target_group_attachment" "instanceA_target_attach" {
  target_group_arn = aws_lb_target_group.instance_target.arn
  target_id        = aws_instance.flugel_instance.id
  port             = 8080
}

resource "aws_lb_target_group_attachment" "instanceB_target_attach" {
  target_group_arn = aws_lb_target_group.instance_target.arn
  target_id        = aws_instance.flugel_instance2.id
  port             = 8080
}

resource "aws_lb_target_group" "instance_target" {
  name     = "routing-requests-to-instances"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = aws_vpc.my_vpc.id
}

