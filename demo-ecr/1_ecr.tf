# Just resource for repository for now
resource "aws_ecr_repository" "app_ecr" {
    name = "app_ecr"
}

output "ecr_repo_url" {
   value = aws_ecr_repository.app_ecr.repository_url
}

output "ecr_repo_id" {
   value = aws_ecr_repository.app_ecr.id
}

output "ecr_repo_img_tag" {
   value = var.ECR_IMG_TAG
}