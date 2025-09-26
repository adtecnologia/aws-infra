resource "aws_iam_policy" "ecr_repo_access" {
  name        = "ecr-ugo-image-repo-access"
  description = "Permissão de acesso ao repositório ECR ugo-image-repo"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "ecr:GetAuthorizationToken"
        ],
        Resource = "*"
      },
      {
        Effect = "Allow",
        Action = [
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage",
          "ecr:BatchCheckLayerAvailability",
          "ecr:PutImage",
          "ecr:InitiateLayerUpload",
          "ecr:UploadLayerPart",
          "ecr:CompleteLayerUpload",
          "ecr:ListImages",
          "ecr:DescribeRepositories",
          "ecr:GetRepositoryPolicy",
          "ecr:DescribeImages",
          "ecr:BatchDeleteImage"
        ],
        Resource = [
          "arn:aws:ecr:sa-east-1:769998260029:repository/ugo-image-repo"
        ]
      }
    ]
  })
}
