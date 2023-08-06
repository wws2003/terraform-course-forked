variable AWS_REGION {
    default = "ap-southeast-1"
}

variable "PATH_TO_PUBLIC_KEY" {
    default = "my_aws_key.pub"
}

variable "AWS_ACCESS_KEY" {
    default = ""
}

variable "AWS_SECRET_KEY" {
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