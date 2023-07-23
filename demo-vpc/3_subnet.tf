resource "aws_subnet" "az1_public_subnet" {
    # Refer to VPC and AZ
    vpc_id = aws_vpc.app_vpc.id
    availability_zone = var.AWS_AZ1

    # CIDR block: 10.0.1.0/24
    cidr_block = "10.0.1.0/24"

    # Map to public
    map_public_ip_on_launch = "true"
}

resource "aws_subnet" "az1_private_subnet" {
    # Refer to VPC and AZ
    vpc_id = aws_vpc.app_vpc.id
    availability_zone = var.AWS_AZ1

    # CIDR block: 10.0.2.0/24
    cidr_block = "10.0.2.0/24"
}

resource "aws_subnet" "az2_public_subnet" {
    # Refer to VPC and AZ
    vpc_id = aws_vpc.app_vpc.id
    availability_zone = var.AWS_AZ2

    # CIDR block: 10.0.3.0/24
    cidr_block = "10.0.3.0/24"

    # Map to public
    map_public_ip_on_launch = "true"
}