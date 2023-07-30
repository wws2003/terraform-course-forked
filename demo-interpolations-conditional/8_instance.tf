resource "aws_instance" "app_instance" {
    # Common AMI, instance type
    ami = var.AMIS[var.AWS_REGION]
    instance_type = "t2.micro"

    # VPC subnet
    # # If prod -> subnet 1
    # # If dev -> subnet 2
    subnet_id = (var.ENV == "prod") ? module.vpc_prod.public_subnets[0] : module.vpc_dev.public_subnets[0]

    # Security group
    # # If prod -> group 1
    # # If dev -> group 2
    vpc_security_group_ids = [var.ENV == "prod" ? aws_security_group.allow_ssh_prod.id : aws_security_group.allow_ssh_dev.id]

    # Common key
    key_name = aws_key_pair.aws_log_server_key.key_name
}