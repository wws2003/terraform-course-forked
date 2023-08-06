
# Fill environment value from var
module "main-vpc" {
    source = "../modules/vpc"
    ENV = "dev"
    AWS_REGION = var.AWS_REGION
}

module "instances" {
    source = "../modules/instances"
    ENV = "dev"
    AWS_REGION = var.AWS_REGION

    # Set vpc_id (for security group)
    VPC_ID = module.main-vpc.vpc_id

    # Set public_subnet (for instance itself)
    PUBLIC_SUBNETS = module.main-vpc.public_subnets

    # Key pair
    PATH_TO_PUBLIC_KEY = var.PATH_TO_PUBLIC_KEY
}