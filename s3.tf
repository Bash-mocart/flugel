resource "aws_s3_bucket" "flugel_s3" {
  bucket = var.s3_bucket

  tags = {
    Name  = "Flugel"
    Owner = "InfraTeam"
  }
}