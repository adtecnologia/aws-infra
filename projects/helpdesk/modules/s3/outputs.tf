# Outputs do módulo S3 do helpdesk

# Informações do bucket
output "s3_bucket_name" {
  description = "Nome do bucket S3"
  value       = aws_s3_bucket.helpdesk_adm_front.bucket
}

output "s3_bucket_arn" {
  description = "ARN do bucket S3"
  value       = aws_s3_bucket.helpdesk_adm_front.arn
}

output "s3_bucket_domain_name" {
  description = "Domain name regional do bucket S3"
  value       = aws_s3_bucket.helpdesk_adm_front.bucket_regional_domain_name
}

# URL do website do bucket helpdesk-adm-front
output "s3_website_endpoint" {
  description = "Website endpoint do bucket helpdesk-adm-front"
  value       = aws_s3_bucket_website_configuration.helpdesk_adm_front.website_endpoint
}

# URL completa do website do bucket helpdesk-adm-front
output "s3_website_url" {
  description = "URL completa do website helpdesk-adm-front"
  value       = "http://${aws_s3_bucket_website_configuration.helpdesk_adm_front.website_endpoint}"
}

# Informações do bucket privado
output "s3_private_bucket_name" {
  description = "Nome do bucket S3 privado"
  value       = aws_s3_bucket.helpdesk_private.bucket
}

output "s3_private_bucket_arn" {
  description = "ARN do bucket S3 privado"
  value       = aws_s3_bucket.helpdesk_private.arn
}