# Outputs do projeto UGO App

# Outputs do usuário IAM completo
output "ugo_complete_user_name" {
  description = "Nome do usuário IAM completo"
  value       = module.IAM.complete_user_name
}

output "ugo_complete_user_arn" {
  description = "ARN do usuário IAM completo"
  value       = module.IAM.complete_user_arn
}

output "ugo_complete_user_access_key_id" {
  description = "Access Key ID do usuário IAM completo"
  value       = module.IAM.complete_user_access_key_id
}

output "ugo_complete_user_secret_access_key" {
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

# Outputs do S3
output "s3_website_endpoint" {
  description = "Website endpoint do bucket ugo-adm-front"
  value       = module.S3.s3_website_endpoint
}

output "s3_website_url" {
  description = "URL completa do website ugo-adm-front"
  value       = module.S3.s3_website_url
}

# Outputs do CloudFront
output "cloudfront_distribution_id" {
  description = "ID da distribuição CloudFront"
  value       = module.CloudFront.cloudfront_distribution_id
}

output "cloudfront_domain_name" {
  description = "Nome do domínio CloudFront"
  value       = module.CloudFront.cloudfront_domain_name
}

output "cloudfront_url" {
  description = "URL HTTPS do CloudFront"
  value       = module.CloudFront.cloudfront_url
}