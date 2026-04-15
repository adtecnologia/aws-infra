output "ecr_repository_url" {
  description = "URL do repositório ECR"
  value       = aws_ecr_repository.helpdesk_image_repo.repository_url
}

output "ecr_repository_arn" {
  description = "ARN do repositório ECR"
  value       = aws_ecr_repository.helpdesk_image_repo.arn
}