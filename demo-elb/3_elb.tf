resource "aws_elb" "app_elb" {
    name = "app-elb"
    security_groups = [aws_security_group.app_elb_securitygroup.id]

    # Subnets: One 2 of public subnets of app_vpc
    subnets = [module.app_vpc.public_subnets[0], module.app_vpc.public_subnets[1]]

    # Simple listener: Mapping port 80 of load balancer to load 80 of app (on EC2 instances)
    listener {
        instance_port     = 80
        instance_protocol = "http"
        lb_port           = 80
        lb_protocol       = "http"
    }

    # Simple healthcheck
    health_check {
        healthy_threshold   = 2
        unhealthy_threshold = 2
        timeout             = 3
        target              = "HTTP:80/"
        interval            = 30
    }

    # Other attributes
    cross_zone_load_balancing   = true
    connection_draining         = true
    connection_draining_timeout = 400
    tags = {
        Name = "my-elb"
    }
}

output "elb_endpoint" {
    value = aws_elb.app_elb.dns_name
}