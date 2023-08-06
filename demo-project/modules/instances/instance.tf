variable "ENV" {
}

variable "AWS_REGION" {
}

variable "INSTANCE_TYPE" {
  default = "t2.micro"
}

variable "PUBLIC_SUBNETS" {
  type = list
}

variable "VPC_ID" {
}

variable "PATH_TO_PUBLIC_KEY" {
    
}

# Instance (still not an module ?)
resource "aws_instance" "instance" {
    # AMI
    ami = var.AMIS[var.AWS_REGION]

    # Instance type
    instance_type = var.INSTANCE_TYPE

    # VPC subnet id
    subnet_id = var.PUBLIC_SUBNETS[0]

    # Security group
    security_groups = [aws_security_group.allow_ssh.id]

    # Key TODO
    key_name = aws_key_pair.key_pair.key_name

    associate_public_ip_address = true

    # Tags
    tags = {
        Name = "instance-${var.ENV}"
        Environmnent = var.ENV
    }
}

# Security group
resource "aws_security_group" "allow_ssh" {
  vpc_id      = var.VPC_ID
  name        = "allow-ssh-${var.ENV}"
  description = "security group that allows ssh and all egress traffic"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name         = "allow-ssh"
    Environmnent = var.ENV
  }
}

# Key pair
resource "aws_key_pair" "key_pair" {
    key_name = "key-${var.ENV}"
    public_key = file(var.PATH_TO_PUBLIC_KEY)
}