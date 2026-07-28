# Outputs do módulo S3 do PGRs

output "s3_bucket_name" {
  description = "Nome do bucket S3"
  value       = aws_s3_bucket.pgrs_front.bucket
}

output "s3_bucket_arn" {
  description = "ARN do bucket S3"
  value       = aws_s3_bucket.pgrs_front.arn
}

output "s3_bucket_domain_name" {
  description = "Domain name regional do bucket S3"
  value       = aws_s3_bucket.pgrs_front.bucket_regional_domain_name
}

output "s3_website_endpoint" {
  description = "Website endpoint do bucket pgrs-front"
  value       = aws_s3_bucket_website_configuration.pgrs_front.website_endpoint
}

output "s3_website_url" {
  description = "URL completa do website pgrs-front"
  value       = "http://${aws_s3_bucket_website_configuration.pgrs_front.website_endpoint}"
}