# Outputs do módulo S3 do Auditoria

output "s3_bucket_name" {
  description = "Nome do bucket S3"
  value       = aws_s3_bucket.auditoria_front.bucket
}

output "s3_bucket_arn" {
  description = "ARN do bucket S3"
  value       = aws_s3_bucket.auditoria_front.arn
}

output "s3_bucket_domain_name" {
  description = "Domain name regional do bucket S3"
  value       = aws_s3_bucket.auditoria_front.bucket_regional_domain_name
}

output "s3_website_endpoint" {
  description = "Website endpoint do bucket auditoria-front"
  value       = aws_s3_bucket_website_configuration.auditoria_front.website_endpoint
}

output "s3_website_url" {
  description = "URL completa do website auditoria-front"
  value       = "http://${aws_s3_bucket_website_configuration.auditoria_front.website_endpoint}"
}