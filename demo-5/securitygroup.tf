# Data
data "aws_ip_ranges" "aws_ips_in_region" {
  regions = ["${var.AWS_REGION}"]
  services = ["ec2"]
}

# output "aws_ips_in_region_vals" {
#   value = slice(data.aws_ip_ranges.aws_ips_in_region.cidr_blocks, 0, 50)
# }

# Security group rule
resource "aws_security_group" "from_aws_region" {
  name = "from_aws_region_${var.AWS_REGION}"

  ingress {
    from_port = "443"
    to_port = "443"
    protocol = "tcp"
    cidr_blocks = slice(data.aws_ip_ranges.aws_ips_in_region.cidr_blocks, 0, 50)
  }

  tags = {
    CreateDate = data.aws_ip_ranges.aws_ips_in_region.create_date
    SyncToken  = data.aws_ip_ranges.aws_ips_in_region.sync_token
  }
}

# ------------------------------------------------------------

# data "aws_ip_ranges" "european_ec2" {
#   regions  = ["eu-west-1", "eu-central-1"]
#   services = ["ec2"]
# }

# resource "aws_security_group" "from_europe" {
#   name = "from_europe"

#   ingress {
#     from_port   = "443"
#     to_port     = "443"
#     protocol    = "tcp"
#     cidr_blocks = slice(data.aws_ip_ranges.european_ec2.cidr_blocks, 0, 50)
#   }
#   tags = {
#     CreateDate = data.aws_ip_ranges.european_ec2.create_date
#     SyncToken  = data.aws_ip_ranges.european_ec2.sync_token
#   }
# }

