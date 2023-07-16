resource "aws_key_pair" "my_key_pair" {
    key_name = "my_aws_key_pair"
    public_key = file(var.PATH_TO_PUBLIC_KEY)
}

resource "aws_instance" "web" {
    ami           = var.AMIS[var.AWS_REGION]
    instance_type = "t2.micro"
    key_name = aws_key_pair.my_key_pair.key_name
    
    # # # Connection
    # connection {
    #     # trying to get the public IP address of an instance if it exists, otherwise use the private IP address.
    #     host = coalesce(self.public_ip, self.private_ip)
    #     user = "${var.INSTANCE_USERNAME}"
    #     type = "ssh"
    #     private_key = file(var.PATH_TO_PRIVATE_KEY)
    # }

    # ... But this will execute the command in the templated-file ?
    user_data = data.template_file.my_templated_file.rendered
}