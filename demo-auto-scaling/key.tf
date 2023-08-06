resource "aws_key_pair" "app_key" {
  key_name   = "app_key"
  public_key = file(var.PATH_TO_PUBLIC_KEY)
}

