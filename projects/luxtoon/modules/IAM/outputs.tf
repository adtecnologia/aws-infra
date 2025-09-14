# Outputs do módulo IAM

# Outputs do usuário completo
output "complete_user_name" {
  description = "Nome do usuário completo"
  value       = aws_iam_user.luxtoon_complete_user.name
}

output "complete_user_arn" {
  description = "ARN do usuário completo"
  value       = aws_iam_user.luxtoon_complete_user.arn
}

output "complete_user_access_key_id" {
  description = "Access Key ID do usuário completo"
  value       = aws_iam_access_key.complete_user_key.id
}

output "complete_user_secret_access_key" {
  description = "Secret Access Key do usuário completo"
  value       = aws_iam_access_key.complete_user_key.secret
  sensitive   = true
}