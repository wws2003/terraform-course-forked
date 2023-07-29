# Resource for vpc
resource "aws_vpc" "app_vpc" {
    # CIDR block: 10.0.0.0/16
    cidr_block = "10.0.0.0/16"

    # Some boilerplate attributes
    instance_tenancy     = "default"
    enable_dns_support   = "true"
    enable_dns_hostnames = "true"

    # Tags
    tags = {
        Name = "app"
    }
}
