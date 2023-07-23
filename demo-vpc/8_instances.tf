resource "aws_instance" "web_server" {
    ami = var.AMIS[var.AWS_REGION]
    instance_type = "t2.micro"

    # Refer to subnet
    subnet_id = aws_subnet.az1_public_subnet.id

    # Refer to security group
    vpc_security_group_ids = [aws_security_group.allow_ssh.id]

    # Key info
    key_name = aws_key_pair.aws_web_server_key.key_name

    # Copy key to db server and log server to access
    provisioner "file" {
        source = var.PATH_TO_DB_SERVER_PRIVATE_KEY
        destination = "/home/${var.INSTANCE_USERNAME}/${aws_key_pair.aws_db_server_key.key_name}"
        connection {
            # trying to get the public IP address of an instance if it exists, otherwise use the private IP address.
            host = coalesce(self.public_ip, self.private_ip)
            user = "${var.INSTANCE_USERNAME}"
            type = "ssh"
            private_key = file(var.PATH_TO_WEB_SERVER_PRIVATE_KEY)
        }
    }

    provisioner "file" {
        source = var.PATH_TO_LOG_SERVER_PRIVATE_KEY
        destination = "/home/${var.INSTANCE_USERNAME}/${aws_key_pair.aws_log_server_key.key_name}"
        connection {
             # trying to get the public IP address of an instance if it exists, otherwise use the private IP address.
            host = coalesce(self.public_ip, self.private_ip)
            user = "${var.INSTANCE_USERNAME}"
            type = "ssh"
            private_key = file(var.PATH_TO_WEB_SERVER_PRIVATE_KEY)
        }
    }

    # TODO Instance nginx: Like provisioner
}

resource "aws_instance" "db_server" {
    ami = var.AMIS[var.AWS_REGION]
    instance_type = "t2.micro"

    # Refer to subnet
    subnet_id = aws_subnet.az1_private_subnet.id

    # Refer to security group (allow ssh to try to access from public-subnet instances)
    vpc_security_group_ids = [aws_security_group.allow_ssh.id]

    # Key info
    key_name = aws_key_pair.aws_db_server_key.key_name

    # TODO Instance some DB like postgres
}

resource "aws_instance" "log_server" {
    ami = var.AMIS[var.AWS_REGION]
    instance_type = "t2.micro"

    # Refer to subnet
    subnet_id = aws_subnet.az2_public_subnet.id

    # Refer to security group
    vpc_security_group_ids = [aws_security_group.allow_ssh.id]
    
    # Key
    key_name = aws_key_pair.aws_log_server_key.key_name

    # TODO Instance some DB like postgres
}