resource "aws_instance" "log_server" {
    ami = var.AMIS[var.AWS_REGION]
    instance_type = "t2.micro"

    # Refer to subnet
    subnet_id = aws_subnet.az2_public_subnet.id

    # Refer to security group
    vpc_security_group_ids = [aws_security_group.allow_ssh.id]
    
    # Key
    key_name = aws_key_pair.aws_log_server_key.key_name

    # Even though cloud init config is ready, user_data is needed
    user_data = data.cloudinit_config.app_cloudinit_config.rendered
}

# Output ip and id and arn of the instance
output "instance_public_ip" {
    value = aws_instance.log_server.public_ip
}
output "instance_id" {
    value = aws_instance.log_server.id
}
output "instance_arn" {
    value = aws_instance.log_server.arn
}