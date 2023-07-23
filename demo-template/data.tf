# Deprecated since terraform v0.12

# # This is similar to a templated-file filled with value
# data "template_file" "my_templated_file" {
#     # Read the template file
#     template = file("init.tpl")

#     # Modify the variable inside the template file
#     vars = {
#         # myip = aws_instance.database1.private_ip
#         # Just for test for now
#         myip = "172.10.16.1"
#     }

#     # What happen then ? A new value-rendered file based on template:
#     # Some things like this will be shown in the state
#     # rendered = <<-EOT
#     #     #! /bin/bash
#     #     echo "database-ip = 172.10.16.1" >> /etc/myapp.config
#     # EOT
# }