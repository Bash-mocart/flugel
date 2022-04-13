module "networking" {
  source   = "../networking"
  environment = var.environment
}

resource "aws_lb" "test" {
  name               = "flugel-nginx-alb-${var.environment}"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [module.networking.sg_allow_8080]
  subnets            = [
     module.networking.subnet_id,
     module.networking.subnet_b_id
  ]

  enable_deletion_protection = false


  tags = {
    Environment = "alb-${var.environment}"
  }
}

resource "aws_lb_listener" "alb-listener-80" {
  load_balancer_arn = aws_lb.test.arn
  port              = "8080"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.instance_target.arn
  }
}


resource "aws_lb_target_group" "instance_target" {
  name     = "routing-requests-${var.environment}"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = module.networking.vpc_id
}

