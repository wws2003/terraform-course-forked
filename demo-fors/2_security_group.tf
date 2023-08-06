resource "aws_security_group" "allow_ssh" {
    # No refer to VPC -> auto refer to default one ?
    
    # Basic info
    name = "allow-ssh"
    description = "security group that allows ssh and all egress traffic for prod environment"

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    dynamic "ingress" {
        for_each = var.ingress_tcp_ports
        content {
            from_port   = ingress.value
            to_port     = ingress.value
            protocol    = "tcp"
        }
    }

    tags = {
        Name = "allow-ssh"
    }
}