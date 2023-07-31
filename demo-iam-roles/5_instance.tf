resource "aws_instance" "app_instance" {
  ami           = var.AMIS[var.AWS_REGION]
  instance_type = "t2.micro"

  # the VPC subnet
  subnet_id = module.vpc_s3_app.public_subnets[0]

  associate_public_ip_address = true

  # the security group
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]

  # the public SSH key
  key_name = aws_key_pair.aws_log_server_key.key_name

  # role:
  iam_instance_profile = aws_iam_instance_profile.app_s3_instance_role_profile.name
}

# Output ip and id and arn of the instance
output "instance_public_ip" {
    value = aws_instance.app_instance.public_ip
}
output "instance_id" {
    value = aws_instance.app_instance.id
}
output "instance_arn" {
    value = aws_instance.app_instance.arn
}