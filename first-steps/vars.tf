variable "AWS_REGION" {
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
        ap-southeast-1 = "ami-0a8c1cf8400c94439"
    }
}