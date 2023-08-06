
# Fill environment value from var
module prod-vpc {
    source = "../modules/vpc"
    ENV = "prod"
    AWS_REGION = var.AWS_REGION
}

module "main-instances" {
    source = "../modules/instances"
    ENV = "prod"
    AWS_REGION = var.AWS_REGION

    # Set vpc_id (for security group)
    VPC_ID = module.prod-vpc.vpc_id

    # Set public_subnet (for instance itself)
    PUBLIC_SUBNETS = module.prod-vpc.public_subnets

    # Key pair
    PATH_TO_PUBLIC_KEY = var.PATH_TO_PUBLIC_KEY
}