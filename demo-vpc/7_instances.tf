# resource "aws_instance" "web_server" {
#     ami = var.AMIS[var.AWS_REGION1]
#     instance_type = "t2.micro"

#     # TODO Instance nginx
# }

# resource "aws_instance" "db_server" {
#     ami = var.AMIS[var.AWS_REGION]
#     instance_type = "t2.micro"

#     # TODO Instance nginx
# }

# resource "aws_instance" "ai_server" {
#     ami = var.AMIS[var.AWS_REGION]
#     instance_type = "t2.micro"

#     # TODO Instance nginx
# }