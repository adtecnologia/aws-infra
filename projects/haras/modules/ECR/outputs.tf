# Outputs do módulo ECR

output "repository_url" {
  description = "URL do repositório ECR"
  value       = aws_ecr_repository.haras_image_repo.repository_url
}

output "repository_name" {
  description = "Nome do repositório ECR"
  value       = aws_ecr_repository.haras_image_repo.name
}

output "repository_arn" {
  description = "ARN do repositório ECR"
  value       = aws_ecr_repository.haras_image_repo.arn
}

output "registry_id" {
  description = "Registry ID do ECR"
  value       = aws_ecr_repository.haras_image_repo.registry_id
}