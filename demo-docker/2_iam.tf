# ECS EC2
# # Role
resource "aws_iam_role" "app_ecs_ec2_role" {
    name = "app_ecs_ec2_role"

    assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
        "Action": "sts:AssumeRole",
        "Principal": {
            "Service": "ec2.amazonaws.com"
        },
        "Effect": "Allow",
        "Sid": ""
        }
    ]
}
EOF
}
# # Profile (what for ? Act as a "container" to pass role for ec2 instance ?)
resource "aws_iam_instance_profile" "app_iam_ec2_profile" {
    name = "app_iam_ec2_profile"
    # Refer to role
    role = aws_iam_role.app_ecs_ec2_role.name
}

# Try not to use consul-related stuff
# resource "aws_iam_role" "ecs-consul-server-role" {
#   name = "ecs-consul-server-role"
#   assume_role_policy = <<EOF
# {
#   "Version": "2012-10-17",
#   "Statement": [
#     {
#       "Action": "sts:AssumeRole",
#       "Principal": {
#         "Service": "ec2.amazonaws.com"
#       },
#       "Effect": "Allow",
#       "Sid": ""
#     }
#   ]
# }
# EOF

# }

# # An inline policy for instance role
resource "aws_iam_role_policy" "app_iam_ec2_role_policy" {
    name = "app_iam_ec2_role_policy"
    
    # Refer to role
    role = aws_iam_role.app_ecs_ec2_role.id

    # The policy document
    policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
            "ecs:CreateCluster",
            "ecs:DeregisterContainerInstance",
            "ecs:DiscoverPollEndpoint",
            "ecs:Poll",
            "ecs:RegisterContainerInstance",
            "ecs:StartTelemetrySession",
            "ecs:Submit*",
            "ecs:StartTask",
            "ecr:GetAuthorizationToken",
            "ecr:BatchCheckLayerAvailability",
            "ecr:GetDownloadUrlForLayer",
            "ecr:BatchGetImage",
            "logs:CreateLogStream",
            "logs:PutLogEvents"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "logs:CreateLogGroup",
                "logs:CreateLogStream",
                "logs:PutLogEvents",
                "logs:DescribeLogStreams"
            ],
            "Resource": [
                "arn:aws:logs:*:*:*"
            ]
        }
    ]
}
EOF
}

# ECS service
# # Role
resource "aws_iam_role" "app_ecs_service_role" {
    name = "app_ecs_service_role"

    # Assume role policy: The service ecs.amazonaws.com can assume policies attached to the role
    assume_role_policy = <<EOF
    {
        "Version": "2012-10-17",
        "Statement": [
            {
            "Action": "sts:AssumeRole",
            "Principal": {
                "Service": "ecs.amazonaws.com"
            },
            "Effect": "Allow",
            "Sid": ""
            }
        ]
    }
    EOF
}

# # Managed policy attachment (role - policy pair)
# AmazonEC2ContainerServiceRole has the following json document
# {
#   "Version" : "2012-10-17",
#   "Statement" : [
#     {
#       "Effect" : "Allow",
#       "Action" : [
#         "ec2:AuthorizeSecurityGroupIngress",
#         "ec2:Describe*",
#         "elasticloadbalancing:DeregisterInstancesFromLoadBalancer",
#         "elasticloadbalancing:DeregisterTargets",
#         "elasticloadbalancing:Describe*",
#         "elasticloadbalancing:RegisterInstancesWithLoadBalancer",
#         "elasticloadbalancing:RegisterTargets"
#       ],
#       "Resource" : "*"
#     }
#   ]
# }
resource "aws_iam_policy_attachment" "app_ecs_role_policy" {
    name = "app_ecs_role_policy"
    roles = [aws_iam_role.app_ecs_service_role.name]
    policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceRole"
}