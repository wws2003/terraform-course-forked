# Public internet gateway
resource "aws_internet_gateway" "app_internet_gateway" {
    # Refer to VPC
    vpc_id = aws_vpc.app_vpc.id

    # Tags
    tags = {
        Name = "app_internet_gw"
    }
}
