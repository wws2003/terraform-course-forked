# Route associations for public subnets
resource "aws_route_table_association" "app_internet_route_table_association1" {
    # Refer to route table id
    # Refer to subnet id
    subnet_id = aws_subnet.az1_public_subnet.id
    route_table_id = aws_route_table.app_public_route_table.id
}

resource "aws_route_table_association" "app_internet_route_table_association2" {
    # Refer to route table id
    # Refer to subnet id
    subnet_id = aws_subnet.az2_public_subnet.id
    route_table_id = aws_route_table.app_public_route_table.id
}
