# Outputs do módulo CloudFront

output "cloudfront_distribution_id" {
  description = "ID da distribuição CloudFront"
  value       = aws_cloudfront_distribution.formais.id
}

output "cloudfront_domain_name" {
  description = "Nome do domínio CloudFront"
  value       = aws_cloudfront_distribution.formais.domain_name
}

output "cloudfront_url" {
  description = "URL do CloudFront"
  value       = "https://${aws_cloudfront_distribution.formais.domain_name}"
}