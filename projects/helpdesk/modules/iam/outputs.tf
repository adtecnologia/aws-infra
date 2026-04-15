output "complete_user_name" {
  description = "Nome do usuário IAM completo"
  value       = aws_iam_user.helpdesk_complete_user.name
}

output "complete_user_arn" {
  description = "ARN do usuário IAM completo"
  value       = aws_iam_user.helpdesk_complete_user.arn
}

output "complete_user_access_key_id" {
  description = "Access Key ID do usuário IAM completo"
  value       = aws_iam_access_key.complete_user_key.id
}

output "complete_user_secret_access_key" {
  description = "Secret Access Key do usuário IAM completo"
  value       = aws_iam_access_key.complete_user_key.secret
  sensitive   = true
}

output "s3_policy_arn" {
  description = "ARN da política de acesso ao S3"
  value       = aws_iam_policy.s3_bucket_access.arn
}

output "ecr_policy_arn" {
  description = "ARN da política de acesso ao ECR"
  value       = aws_iam_policy.ecr_repo_access.arn
}

output "cloudfront_policy_arn" {
  description = "ARN da política de acesso ao CloudFront"
  value       = aws_iam_policy.cloudfront_access.arn
}