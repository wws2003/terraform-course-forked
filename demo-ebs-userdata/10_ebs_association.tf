# Binding EBS and instance
resource "aws_volume_attachment" "aws_volume_1_attachment" {
    # Device name: Must follow some convention ???
    device_name = var.INSTANCE_DEVICE_NAME

    # Refer to volume
    volume_id = aws_ebs_volume.ebs_volume1.id

    # Refer to instance
    instance_id = aws_instance.log_server.id
}

# What happens if more than one instances attaching one volumes ?