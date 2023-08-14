# Define resource for codebuild project
resource "aws_codebuild_project" "app_codebuild" {
    # Basic attributes

    # Artifact
    artifact = {

    }

    # Environment
    environment {
      environment_variable {
        
      }

      environment_variable {
        
      }

      environment_variable {

      }
    }

    # Source
    source = {
        type = "CODEPIPELINE"
        buildspec = "buildspec.yml"
    }
}