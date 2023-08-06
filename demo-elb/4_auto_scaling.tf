# Auto-scaling launch configuration
resource "aws_launch_configuration" "app_auto_scaling_lauch_configuration" {
    # Define attributes for instances
    name_prefix     = "app-launchconfig"
    image_id        = var.AMIS[var.AWS_REGION]
    instance_type   = "t2.micro"
    key_name        = aws_key_pair.app_key.key_name
    security_groups = [aws_security_group.allow_ssh_and_elb.id]

    # Install nginx and showing ip address at home page
    user_data       = "#!/bin/bash\napt-get update\napt-get -y install net-tools nginx\nMYIP=`ifconfig | grep -E '(inet 10)|(addr:10)' | awk '{ print $2 }' | cut -d ':' -f2`\necho 'this is: '$MYIP > /var/www/html/index.html"
    lifecycle {
        create_before_destroy = true
    }
}

# Auto-scaling group
resource "aws_autoscaling_group" "app_auto_scaling_group" {
    name = "app_auto_scaling_group"
    launch_configuration = aws_launch_configuration.app_auto_scaling_lauch_configuration.name

    # VPC setting
    # vpc_zone_identifier = [aws_subnet.main-public-1.id, aws_subnet.main-public-2.id]
    # List of subnet IDs to launch resources in. Subnets automatically determine which availability zones the group will reside.
    vpc_zone_identifier = [module.app_vpc.public_subnets[0], module.app_vpc.public_subnets[1]]

    # Refer to ELB load balancer
    min_size                  = 2
    max_size                  = 2
    health_check_grace_period = 300
    health_check_type         = "ELB"
    load_balancers            = [aws_elb.app_elb.name]
    force_delete              = true

    tag {
        key                 = "Name"
        value               = "ec2 instance"
        propagate_at_launch = true
    }
}

# # No policy, as it is handled by the ELB