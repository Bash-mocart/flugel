resource "aws_s3_bucket" "flugel_s3" {
  bucket = "bashox1234567890"

  tags = {
    Name  = "Flugel"
    Owner = "InfraTeam"
  }
}