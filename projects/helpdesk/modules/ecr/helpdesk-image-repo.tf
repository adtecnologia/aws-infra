# Elastic Container Registry para o Helpdesk
resource "aws_ecr_repository" "helpdesk_image_repo" {
  name                 = "helpdesk-image-repo"
  image_tag_mutability = "MUTABLE"
  tags = {
    Environment = var.environment
    Project     = var.project
  }
}

resource "aws_ecr_lifecycle_policy" "helpdesk_image_repo_policy" {
  repository = aws_ecr_repository.helpdesk_image_repo.name
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