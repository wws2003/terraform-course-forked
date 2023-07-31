resource "aws_s3_bucket" "app_s3_my_bucket" {
  bucket = "app-bucket-c29df1-x"

  tags = {
    Name = "app-bucket-c29df1-x"
  }
}