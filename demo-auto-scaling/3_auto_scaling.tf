# Auto-scaling launch configuration
resource "aws_launch_configuration" "app_auto_scaling_lauch_configuration" {
    # Define attributes for instances
    name_prefix     = "app-launchconfig"
    image_id        = var.AMIS[var.AWS_REGION]
    instance_type   = "t2.micro"
    key_name        = aws_key_pair.app_key.key_name
    security_groups = [aws_security_group.allow_ssh.id]
}

# Auto-scaling group
resource "aws_autoscaling_group" "app_auto_scaling_group" {
    name = "app_auto_scaling_group"
    launch_configuration = aws_launch_configuration.app_auto_scaling_lauch_configuration.name

    # VPC setting
    # vpc_zone_identifier = [aws_subnet.main-public-1.id, aws_subnet.main-public-2.id]
    # List of subnet IDs to launch resources in. Subnets automatically determine which availability zones the group will reside.
    vpc_zone_identifier = [module.app_vpc.public_subnets[0], module.app_vpc.public_subnets[1]]

    # Launch maximum 2 instances
    min_size                  = 1
    max_size                  = 2
    health_check_grace_period = 300
    health_check_type         = "EC2"
    force_delete              = true

    tag {
        key                 = "Name"
        value               = "ec2 instance"
        propagate_at_launch = true
    }
}