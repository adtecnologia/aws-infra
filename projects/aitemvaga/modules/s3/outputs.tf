# Outputs do módulo S3 do aitemvaga

# Informações do bucket
output "s3_bucket_name" {
  description = "Nome do bucket S3"
  value       = aws_s3_bucket.aitemvaga_front.bucket
}

output "s3_bucket_arn" {
  description = "ARN do bucket S3"
  value       = aws_s3_bucket.aitemvaga_front.arn
}

output "s3_bucket_domain_name" {
  description = "Domain name regional do bucket S3"
  value       = aws_s3_bucket.aitemvaga_front.bucket_regional_domain_name
}

# URL do website do bucket aitemvaga-front
output "s3_website_endpoint" {
  description = "Website endpoint do bucket aitemvaga-front"
  value       = aws_s3_bucket_website_configuration.aitemvaga_front.website_endpoint
}

# URL completa do website do bucket aitemvaga-front
output "s3_website_url" {
  description = "URL completa do website aitemvaga-front"
  value       = "http://${aws_s3_bucket_website_configuration.aitemvaga_front.website_endpoint}"
}