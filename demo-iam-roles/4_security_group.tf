resource "aws_security_group" "allow_ssh" {
    # Refer to VPC
    vpc_id = module.vpc_s3_app.vpc_id

    # Basic info
    name = "allow-ssh"
    description = "security group that allows ssh and all egress traffic for prod environment"

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = {
        Name = "allow-ssh"
    }
}