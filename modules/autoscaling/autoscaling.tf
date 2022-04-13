
resource "aws_autoscaling_group" "flugel_autoscaling" {
  desired_capacity   = 2
  max_size           = 2
  min_size           = 2
  

  launch_template {
    id      = aws_launch_template.nginx_launch.id
    version = aws_launch_template.nginx_launch.latest_version
  }

    vpc_zone_identifier  = [ var.subnet_id,
        var.subnet_b_id
     ]
    lifecycle {
        ignore_changes = [load_balancers, target_group_arns]
    }

  
    tag {
        key                = "Name"
        value              = "Flugel"
        propagate_at_launch = true
  }

     tag {
        key                = "Owner"
        value              = "InfraTeam"
        propagate_at_launch = true
  }

   tag {
        key                = "environment"
        value              = "autoscaling-${var.environment}"
        propagate_at_launch = true
  }

}

resource "aws_autoscaling_attachment" "asg_attachment_bar" {
  autoscaling_group_name = aws_autoscaling_group.flugel_autoscaling.id
  lb_target_group_arn    = var.aws_lb_target_group_arn
}




