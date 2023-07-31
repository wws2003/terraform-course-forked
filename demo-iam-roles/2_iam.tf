# Role
resource "aws_iam_role" "app_s3_my_bucket_role" {
    name = "app_s3_my_bucket_role"
    # Assume for EC2
    assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

}
# Role profile for instance
resource "aws_iam_instance_profile" "app_s3_instance_role_profile" {
  name = "app_s3_instance_role_profile"
  role = aws_iam_role.app_s3_my_bucket_role.name
}

# Attach policy to role (inline policies ?)
resource "aws_iam_role_policy" "app_s3_my_bucket_role_policy" {
    name = "app_s3_my_bucket_role_policy"
    role = aws_iam_role.app_s3_my_bucket_role.id
    policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
              "s3:*"
            ],
            "Resource": [
              "arn:aws:s3:::app-bucket-c29df1-x",
              "arn:aws:s3:::app-bucket-c29df1-x/*"
            ]
        }
    ]
}
EOF

}