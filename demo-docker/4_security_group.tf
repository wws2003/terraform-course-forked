# Security group for instances
resource "aws_security_group" "allow_ssh_and_elb" {
    vpc_id      = module.vpc_ecs_app.vpc_id
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
        from_port   = 3000
        to_port     = 3000
        protocol    = "tcp"
        security_groups = [aws_security_group.app_elb_securitygroup.id]
    }

    tags = {
        Name = "allow-ssh-and-elb"
    }
}

# Security group for ELB
resource "aws_security_group" "app_elb_securitygroup" {
    vpc_id      = module.vpc_ecs_app.vpc_id
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
        to_port     = var.LOAD_BALANCER_PORT
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    
    tags = {
        Name = "elb"
    }   
}