# Elastic Container Registry para o UGO App
resource "aws_ecr_repository" "ugo_image_repo" {
  name                 = "ugo-image-repo"
  image_tag_mutability = "MUTABLE"
  tags = {
    Environment = "agnostic"
    Project     = "ugo-app"
  }
}

resource "aws_ecr_lifecycle_policy" "ugo_image_repo_policy" {
  repository = aws_ecr_repository.ugo_image_repo.name
  policy     = <<EOF
{
  "rules": [
    {
      "rulePriority": 1,
      "description": "Remove imagens não tagueadas com mais de 1 dia",
      "selection": {
        "tagStatus": "untagged",
        "countType": "sinceImagePushed",
        "countUnit": "days",
        "countNumber": 1
      },
      "action": {
        "type": "expire"
      }
    },
    {
      "rulePriority": 2,
      "description": "Manter apenas as 3 imagens mais recentes com qualquer tag",
      "selection": {
        "tagStatus": "tagged",
        "tagPrefixList": ["v", "latest", "dev", "prod"],
        "countType": "imageCountMoreThan",
        "countNumber": 3
      },
      "action": {
        "type": "expire"
      }
    }
  ]
}
EOF
}