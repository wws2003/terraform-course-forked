variable "AWS_REGION" {
    type = string
    default = ""
}

variable "AWS_AZ1" {
    type = string
    default = ""
}

variable "AWS_AZ2" {
    type = string
    default = ""
}

variable "AWS_ACCESS_KEY" {
    type = string
    default = ""
}

variable "AWS_SECRET_KEY" {
    type = string
    default = ""
}

variable AMIS {
    type = map(string)
    default = {
        us-west-1 = "ami-13be557e"
        ap-southeast-1 = "ami-0f74c08b8b5effa56"
        ap-northeast-1 = "ami-0f74c08b8b5effa56"
    }
}

# Log server key
variable "PATH_TO_LOG_SERVER_PRIVATE_KEY" {
  default = "keys/log_server_key"
}

variable "PATH_TO_LOG_SERVER_PUBLIC_KEY" {
  default = "keys/log_server_key.pub"
}

variable "INSTANCE_USERNAME" {
  default = "ubuntu"
}

# Instance device name
variable "INSTANCE_DEVICE_NAME" {
    default = "/dev/xvdh"
}

# Instance device name
variable "ENV" {
    default = "prod"
}

## Variable for for
variable project_tags {
    type = map(string)
    default = {
        "Component" = "Frontend"
        "Environment" = "Production"
    }
}

variable ingress_tcp_ports {
    type = list(number)
    default = [22, 443]
}

