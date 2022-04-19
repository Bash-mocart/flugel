output "alb-dns" {
  value       = aws_lb.test.dns_name
  description = "s3 bucket tags"
}

output "alb-target_group_arn" {
  value       = aws_lb_target_group.instance_target.arn
}