#!/bin/bash
PROFILE=iam_user
ECR_REPO_URL=$(terraform output -raw ecr_repo_url)
ECR_REPO_ID=$(terraform output -raw ecr_repo_id)
ECR_URL=${ECR_REPO_URL/\/${ECR_REPO_ID}/}
TAG=$(terraform output -raw ecr_repo_img_tag)

# echo $ECR_REPO_URL
# echo $ECR_REPO_ID
# echo $ECR_URL

# # Build image at local machine
cd src
docker rmi ${ECR_REPO_URL}:${TAG}
docker build -t ${ECR_REPO_URL}:${TAG} .
cd ..
# # Login
aws ecr get-login-password --profile ${PROFILE} | docker login --username AWS --password-stdin ${ECR_URL}
# # Push image
docker push ${ECR_REPO_URL}:${TAG}
