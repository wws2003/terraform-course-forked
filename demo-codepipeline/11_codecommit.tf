# Just repo resource for codecommit
resource "aws_codecommit_repository" "app_code_repo" {
    repository_name = "app_code_repo"
    description     = "This is the demo repository"
}