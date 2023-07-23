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

variable "PATH_TO_PRIVATE_KEY" {
  default = "my_aws_key"
}

variable "PATH_TO_PUBLIC_KEY" {
  default = "my_aws_key.pub"
}

variable "INSTANCE_USERNAME" {
  default = "ubuntu"
}
