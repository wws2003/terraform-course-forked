# resource "aws_key_pair" "mykey" {
#   key_name   = "mykey"
#   public_key = file(var.PATH_TO_PUBLIC_KEY)
# }

# resource "aws_instance" "example" {
#   ami           = var.AMIS[var.AWS_REGION]
#   instance_type = "t2.micro"
#   key_name      = aws_key_pair.mykey.key_name

#   provisioner "file" {
#     source      = "script.sh"
#     destination = "/tmp/script.sh"
#   }
#   provisioner "remote-exec" {
#     inline = [
#       "chmod +x /tmp/script.sh",
#       "sudo sed -i -e 's/\r$//' /tmp/script.sh",  # Remove the spurious CR characters.
#       "sudo /tmp/script.sh",
#     ]
#   }
#   connection {
#     host        = coalesce(self.public_ip, self.private_ip)
#     type        = "ssh"
#     user        = var.INSTANCE_USERNAME
#     private_key = file(var.PATH_TO_PRIVATE_KEY)
#   }
# }


# Key pair resource
resource "aws_key_pair" "my_key_pair" {
    key_name = "my_aws_key"
    public_key = file("${var.PATH_TO_PUBLIC_KEY}")
}

# Instance resource (with 2 provisioners: file and remote exec and one connection inside)
resource "aws_instance" "instance1" {

    # # Basic info
    ami = "${var.AMIS[var.AWS_REGION]}"
    instance_type = "t2.micro"
    key_name = aws_key_pair.my_key_pair.key_name

    # # Provisioners
    provisioner "file" {
        source = "script.sh"
        destination = "/tmp/script.sh"
    }

    provisioner "remote-exec" {
        inline = [
            "chmod +x /tmp/script.sh",
            "sudo sed -i -e 's/\r$//' /tmp/script.sh",  # Remove the spurious CR characters.
            "sudo /tmp/script.sh",
        ]
    }

    # # Connection
    connection {
        # trying to get the public IP address of an instance if it exists, otherwise use the private IP address.
        host = coalesce(self.public_ip, self.private_ip)
        user = "${var.INSTANCE_USERNAME}"
        type = "ssh"
        private_key = file(var.PATH_TO_PRIVATE_KEY)
    }
}

# Output: Public IP, ARN and vpc_security_group_ids
output "ec2_instance_info1" {
    value = "${aws_instance.instance1.public_ip}"
}
output "ec2_instance_info2" {
    value = "${aws_instance.instance1.arn}"
}
output "ec2_instance_info3" {
    value = "${aws_instance.instance1.vpc_security_group_ids}"
}