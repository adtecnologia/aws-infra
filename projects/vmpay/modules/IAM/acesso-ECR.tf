resource "aws_iam_policy" "ecr_policy" {
  name        = "ecr-vmpay-image-repo-access"
  description = "Policy for ECR access for vmpay"

  policy = jsonencode({
    Version = "2012-10-17"
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
          "arn:aws:ecr:us-east-1:769998260029:repository/vmpay-image-repo"
        ]
      }
    ]
  })
}
