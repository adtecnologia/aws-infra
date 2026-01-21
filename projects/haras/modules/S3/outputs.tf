# Outputs do módulo S3 do Haras App

# Informações do bucket
output "s3_bucket_name" {
  description = "Nome do bucket S3"
  value       = aws_s3_bucket.haras_adm_front.bucket
}

output "s3_bucket_arn" {
  description = "ARN do bucket S3"
  value       = aws_s3_bucket.haras_adm_front.arn
}

output "s3_bucket_domain_name" {
  description = "Domain name regional do bucket S3"
  value       = aws_s3_bucket.haras_adm_front.bucket_regional_domain_name
}

# URL do website do bucket haras-adm-front
output "s3_website_endpoint" {
  description = "Website endpoint do bucket haras-adm-front"
  value       = aws_s3_bucket_website_configuration.haras_adm_front.website_endpoint
}

# URL completa do website do bucket haras-adm-front
output "s3_website_url" {
  description = "URL completa do website haras-adm-front"
  value       = "http://${aws_s3_bucket_website_configuration.haras_adm_front.website_endpoint}"
}