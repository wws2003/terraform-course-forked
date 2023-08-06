resource "aws_ebs_volume" "app_volume1" {
    availability_zone = var.AWS_AZ1

    # What does this mean: 8GB volume
    size = 8

    tags = {for k, v in merge({Name = "My volume"}, var.project_tags) : k => v}
}