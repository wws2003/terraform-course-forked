# ECS cluster
resource "aws_ecs_cluster" "app_cluster" {
    name = "app_cluster"
}

# Scaling group-related
resource "aws_launch_configuration" "app_aws_launch_configuration"{
    name = "app_aws_launch_configuration"

    # Instance info: ami, type
    # # Note: The AMI supporting AMI can be found by the command aws ssm get-parameters --names /aws/service/ecs/optimized-ami/amazon-linux-2/recommended --region ap-southeast-1
    image_id = var.AMIS[var.AWS_REGION]
    instance_type = "t2.micro"

    # Instance info 2: iam profile
    iam_instance_profile = aws_iam_instance_profile.app_iam_ec2_profile.id

    # Instance info 3: security, key
    key_name = aws_key_pair.my_key_pair.key_name
    security_groups = [aws_security_group.allow_ssh_and_elb.id]

    # User-data: Start ECS agent
    user_data = "#!/bin/bash\necho 'ECS_CLUSTER=app_cluster' > /etc/ecs/ecs.config\nstart ecs"

    lifecycle {
        create_before_destroy = true
    }
}

resource "aws_autoscaling_group" "app_aws_autoscaling_group" {
    name = "aws_autoscaling_group"
    
    # Launch configuration
    launch_configuration = aws_launch_configuration.app_aws_launch_configuration.name

    # AZ
    vpc_zone_identifier = [module.vpc_ecs_app.public_subnets[0], module.vpc_ecs_app.public_subnets[1]]

    # Number of instances
    min_size = 1
    max_size = 2

    # Other info
    tag {
        key                 = "Name"
        value               = "ecs-ec2-container"
        propagate_at_launch = true
    }
}