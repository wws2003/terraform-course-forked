# EIP (details in later lessons)
resource "aws_eip" "nat_eip" {
    domain = "vpc"
}

# NAT gateway
resource "aws_nat_gateway" "app_nat_gateway" {
    # Allocation id (refer to EIP)
    allocation_id = aws_eip.nat_eip.id

    # Refer to subnet (the subnet to push the gateway on -> Should be the public subnet)
    subnet_id = aws_subnet.az1_public_subnet.id

    # Refer (depends on) to internet gateway
    depends_on = [aws_internet_gateway.app_internet_gateway]
}

# NAT route table
resource "aws_route_table" "app_nat_route_table" {
    # Refer to VPC
    vpc_id = aws_vpc.app_vpc.id

    # Routes (refer to internet gateway)
    route {
        # All traffic except VPC internal is going to internet gateway
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.app_nat_gateway.id
    }

    tags = {
        Name = "app_nat_route_table"
    }
}

# # NAT route table associations
resource "aws_route_table_association" "app_nat_route_table_association1" {
    # Refer to route table id
    # Refer to subnet id
    subnet_id = aws_subnet.az1_private_subnet.id
    route_table_id = aws_route_table.app_nat_route_table.id
}


