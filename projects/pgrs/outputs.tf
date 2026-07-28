# Outputs do projeto PGRs

output "s3_bucket_name" {
  description = "Nome do bucket S3 do frontend"
  value       = module.S3.s3_bucket_name
}

output "cloudfront_domain_name" {
  description = "Domínio do CloudFront"
  value       = module.CloudFront.cloudfront_domain_name
}

output "cloudfront_url" {
  description = "URL do CloudFront"
  value       = module.CloudFront.cloudfront_url
}

output "acm_certificate_arn" {
  description = "ARN do certificado ACM"
  value       = module.CloudFront.acm_certificate_arn
}

output "s3_website_endpoint" {
  description = "S3 website endpoint"
  value       = module.S3.s3_website_endpoint
}