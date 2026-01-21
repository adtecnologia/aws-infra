# Elastic Container Registry para o Haras App
resource "aws_ecr_repository" "haras_image_repo" {
  name                 = "haras-image-repo"
  image_tag_mutability = "MUTABLE"
  tags = {
    Environment = "agnostic"
    Project     = "haras-app"
  }
}

resource "aws_ecr_lifecycle_policy" "haras_image_repo_policy" {
  repository = aws_ecr_repository.haras_image_repo.name
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
      "description": "Manter apenas uma imagem mais recente com qualquer tag",
      "selection": {
        "tagStatus": "tagged",
        "tagPrefixList": ["v", "latest", "dev", "prod"],
        "countType": "imageCountMoreThan",
        "countNumber": 1
      },
      "action": {
        "type": "expire"
      }
    }
  ]
}
EOF
}