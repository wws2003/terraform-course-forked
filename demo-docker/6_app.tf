# ECS task definition
resource "aws_ecs_task_definition" "app_ecs_task_definition" {
    family = "my_sample_app"
    container_definitions = templatefile("templates/app.json.tpl", {
        REPOSITORY_URL = replace(aws_ecr_repository.app_ecr.repository_url, "https://", ""),
        IMG_TAG = var.ECR_IMG_TAG
    })
}

# ELB
resource "aws_elb" "app_elb" {
    name = "app-elb"
    
    listener {
        instance_port     = 3000
        instance_protocol = "http"
        # Load balancer port is 80
        lb_port           = var.LOAD_BALANCER_PORT
        lb_protocol       = "http"
    }

    health_check {
        healthy_threshold   = 3
        unhealthy_threshold = 3
        timeout             = 30
        target              = "HTTP:3000/"
        interval            = 60
    }

    # Subnet, security group
    security_groups = [aws_security_group.app_elb_securitygroup.id]

    # Subnets: One 2 of public subnets of app_vpc
    subnets = [module.vpc_ecs_app.public_subnets[0], module.vpc_ecs_app.public_subnets[1]]

    # Other attributes
    cross_zone_load_balancing   = true
    idle_timeout                = 400
    connection_draining         = true
    connection_draining_timeout = 400

    tags = {
        Name = "myapp-elb"
    }
}

# ECS service: wiring components 
resource "aws_ecs_service" "app_ecs_service" {
    name = "app_ecs_service"
    count = 1

    # Refer to ECS cluster, ECS task definition, ELB
    cluster = aws_ecs_cluster.app_cluster.id
    task_definition = aws_ecs_task_definition.app_ecs_task_definition.arn

    # # Number of (logical) task expected to run in ECS service
    desired_count = 1

    load_balancer {
        elb_name = aws_elb.app_elb.name
        container_name = "myapp"
        container_port = 3000
    }

    # IAM role: ECS Service role
    iam_role = aws_iam_role.app_ecs_service_role.arn
    # # What does this mean: Wait for the managed policy is attached to the role before spinup
    depends_on = [aws_iam_policy_attachment.app_ecs_role_policy]

    lifecycle {
        ignore_changes = [task_definition]
    }
}
