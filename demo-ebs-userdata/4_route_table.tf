# Public route table (to be pushed into associated instances)
resource "aws_route_table" "app_public_route_table" {
    # Refer to VPC
    vpc_id = aws_vpc.app_vpc.id

    # Routes (refer to internet gateway)
    route {
        # All traffic except VPC internal is going to internet gateway
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.app_internet_gateway.id
    }
}
