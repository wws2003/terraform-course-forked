resource "aws_security_group" "allow_ssh_and_elb" {
    vpc_id      = module.app_vpc.vpc_id
    name        = "allow-ssh-and-elb"
    description = "security group for instance"

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

    # Access from elb
    ingress {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        security_groups = [aws_security_group.app_elb_securitygroup.id]
    }

    tags = {
        Name = "allow-ssh-and-elb"
    }
}

resource "aws_security_group" "app_elb_securitygroup" {
    vpc_id      = module.app_vpc.vpc_id
    name        = "elb"
    description = "security group for load balancer"
    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    
    tags = {
        Name = "elb"
    }
}

