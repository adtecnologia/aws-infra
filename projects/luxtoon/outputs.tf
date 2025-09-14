# Outputs do projeto Luxtoon

# Outputs do usuário IAM completo
output "luxtoon_complete_user_name" {
  description = "Nome do usuário IAM completo"
  value       = module.IAM.complete_user_name
}

output "luxtoon_complete_user_arn" {
  description = "ARN do usuário IAM completo"
  value       = module.IAM.complete_user_arn
}

output "luxtoon_complete_user_access_key_id" {
  description = "Access Key ID do usuário IAM completo"
  value       = module.IAM.complete_user_access_key_id
}

output "luxtoon_complete_user_secret_access_key" {
  description = "Secret Access Key do usuário IAM completo"
  value       = module.IAM.complete_user_secret_access_key
  sensitive   = true
}

# Outputs do repositório ECR
output "ecr_repository_url" {
  description = "URL do repositório ECR"
  value       = module.ECR.repository_url
}

output "ecr_repository_name" {
  description = "Nome do repositório ECR"
  value       = module.ECR.repository_name
}

output "ecr_registry_id" {
  description = "Registry ID do ECR"
  value       = module.ECR.registry_id
}