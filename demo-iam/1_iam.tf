# Group definition
resource "aws_iam_group" "app_administrator" {
    name = "tf_administrator"
}

# # Attach policy to group
# aws iam get-policy --policy-arn arn:aws:iam::aws:policy/AdministratorAccess --profile iam_user
# {
#     "Policy": {
#         "PolicyName": "AdministratorAccess",
#         "PolicyId": "ANPAIWMBCKSKIEE64ZLYK",
#         "Arn": "arn:aws:iam::aws:policy/AdministratorAccess",
#         "Path": "/",
#         "DefaultVersionId": "v1",
#         "AttachmentCount": 2,
#         "PermissionsBoundaryUsageCount": 0,
#         "IsAttachable": true,
#         "Description": "Provides full access to AWS services and resources.",
#         "CreateDate": "2015-02-06T18:39:46Z",
#         "UpdateDate": "2015-02-06T18:39:46Z",
#         "Tags": []
#     }
# }
resource "aws_iam_policy_attachment" "administrator_policy_attachment" {
    name = "tf_administrator_policy_attachment"
    groups = [aws_iam_group.app_administrator.name]
    policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

# User definition
resource "aws_iam_user" "tf_admin_user1" {
    name = "tf_admin_user1"
}

resource "aws_iam_user" "tf_admin_user2" {
    name = "tf_admin_user2"
}

# # Assign users to groups
resource "aws_iam_group_membership" "tf_administrator_users" {
    name = "tf_administrator_users"

    users = [
        aws_iam_user.tf_admin_user1.name,
        aws_iam_user.tf_admin_user2.name,
    ]

    group = aws_iam_group.app_administrator.name
}