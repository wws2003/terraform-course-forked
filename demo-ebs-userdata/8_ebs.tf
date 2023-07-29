# Volume
resource "aws_ebs_volume" "ebs_volume1"{
    # AZ
    availability_zone = aws_subnet.az2_public_subnet.availability_zone

    # Attributes (size, type)
    size = 20
    # # General purpose
    type = "gp2"

    tags = {
        Name = "volume1"
    }
}