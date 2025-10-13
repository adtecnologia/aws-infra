# Outputs do módulo CloudFront

# ARN da distribuição CloudFront
output "cloudfront_distribution_arn" {
  description = "ARN da distribuição CloudFront"
  value       = aws_cloudfront_distribution.ugo_adm_front.arn
}

# URL do CloudFront
output "cloudfront_distribution_id" {
  description = "ID da distribuição CloudFront"
  value       = aws_cloudfront_distribution.ugo_adm_front.id
}

output "cloudfront_domain_name" {
  description = "Nome do domínio CloudFront"
  value       = aws_cloudfront_distribution.ugo_adm_front.domain_name
}

output "cloudfront_hosted_zone_id" {
  description = "Hosted Zone ID do CloudFront"
  value       = aws_cloudfront_distribution.ugo_adm_front.hosted_zone_id
}

output "cloudfront_url" {
  description = "URL completa do CloudFront"
  value       = "https://${aws_cloudfront_distribution.ugo_adm_front.domain_name}"
}