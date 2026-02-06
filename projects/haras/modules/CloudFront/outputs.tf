# Outputs do módulo CloudFront

# ARN da distribuição CloudFront
output "cloudfront_distribution_arn" {
  description = "ARN da distribuição CloudFront"
  value       = aws_cloudfront_distribution.haras_front.arn
}

# URL do CloudFront
output "cloudfront_distribution_id" {
  description = "ID da distribuição CloudFront"
  value       = aws_cloudfront_distribution.haras_front.id
}

output "cloudfront_domain_name" {
  description = "Nome do domínio CloudFront"
  value       = aws_cloudfront_distribution.haras_front.domain_name
}

output "cloudfront_hosted_zone_id" {
  description = "Hosted Zone ID do CloudFront"
  value       = aws_cloudfront_distribution.haras_front.hosted_zone_id
}

output "cloudfront_url" {
  description = "URL completa do CloudFront"
  value       = "https://${aws_cloudfront_distribution.haras_front.domain_name}"
}

output "acm_certificate_validation_records" {
  description = "Registros DNS necessários para validação do certificado ACM"
  value = {
    for dvo in aws_acm_certificate.haras_front.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }
}
