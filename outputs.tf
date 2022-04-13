# output "instance_tag" {
#   value       = aws_instance.flugel_instance.tags_all
#   description = "VPC id."
#   # Setting an output value as sensitive prevents Terraform from showing its value in plan and apply.
#   sensitive = false
# }

# output "s3_tag" {
#   value       = aws_s3_bucket.flugel_s3.tags
#   description = "s3 bucket tags"
#   # Setting an output value as sensitive prevents Terraform from showing its value in plan and apply.
#   sensitive = false
# }

# output "instanceA-ip" {
#   value       = aws_instance.flugel_instance2.public_ip
#   description = "s3 bucket tags"
#   # Setting an output value as sensitive prevents Terraform from showing its value in plan and apply.
#   sensitive = false
# }


# output "instanceB-ip" {
#   value       = aws_instance.flugel_instance.public_ip
#   description = "s3 bucket tags"
#   # Setting an output value as sensitive prevents Terraform from showing its value in plan and apply.
#   sensitive = false
# }

output "alb-dns" {
  value       = aws_lb.test.dns_name
  description = "s3 bucket tags"
  # Setting an output value as sensitive prevents Terraform from showing its value in plan and apply.
  sensitive = false
}

