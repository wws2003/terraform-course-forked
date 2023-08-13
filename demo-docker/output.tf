output "ecr_repo_url" {
   value = aws_ecr_repository.app_ecr.repository_url
}

output "ecr_repo_id" {
   value = aws_ecr_repository.app_ecr.id
}

output "elb_endpoint" {
    value = aws_elb.app_elb.dns_name
}