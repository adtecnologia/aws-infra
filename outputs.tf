# Outputs da infraestrutura completa

# =============================================================================
# OUTPUTS DO PROJETO UGO-APP
# =============================================================================

output "ugo_app_user_access_key_id" {
  description = "Access Key ID do usuário IAM completo do UGO App"
  value       = module.ugo_app.ugo_complete_user_access_key_id
}

output "ugo_app_complete_user_secret_access_key" {
  description = "Secret Access Key do usuário IAM completo do UGO App"
  value       = module.ugo_app.ugo_complete_user_secret_access_key
  sensitive   = true
}

# output "ugo_app_cloudfront_url" {
#   description = "URL HTTPS do CloudFront para o UGO Admin Frontend"
#   value       = module.ugo_app.cloudfront_url
# }

# output "ugo_app_cloudfront_domain" {
#   description = "Domínio CloudFront para o UGO Admin Frontend"
#   value       = module.ugo_app.cloudfront_domain_name
# }

# output "ugo_app_s3_website_url" {
#   description = "URL do S3 website para o UGO Admin Frontend"
#   value       = module.ugo_app.s3_website_url
# }

# =============================================================================
# OUTPUTS DO PROJETO LUXTOON
# =============================================================================

output "luxtoon_user_access_key_id" {
  description = "Access Key ID do usuário IAM completo do Luxtoon"
  value       = module.luxtoon.luxtoon_complete_user_access_key_id
}

output "luxtoon_complete_user_secret_access_key" {
  description = "Secret Access Key do usuário IAM completo do Luxtoon"
  value       = module.luxtoon.luxtoon_complete_user_secret_access_key
  sensitive   = true
}

# =============================================================================
# OUTPUTS DO PROJETO PETLOVE
# =============================================================================

output "petlove_user_access_key_id" {
  description = "Access Key ID do usuário IAM completo do Petlove"
  value       = module.petlove.petlove_complete_user_access_key_id
}

output "petlove_complete_user_secret_access_key" {
  description = "Secret Access Key do usuário IAM completo do Petlove"
  value       = module.petlove.petlove_complete_user_secret_access_key
  sensitive   = true
}

# =============================================================================
# OUTPUTS DO PROJETO FOR+
# =============================================================================

output "forplus_user_access_key_id" {
  description = "Access Key ID do usuário IAM completo do For+"
  value       = module.forplus.forplus_complete_user_access_key_id
}

output "forplus_complete_user_secret_access_key" {
  description = "Secret Access Key do usuário IAM completo do For+"
  value       = module.forplus.forplus_complete_user_secret_access_key
  sensitive   = true
}

# =============================================================================
# OUTPUTS DO PROJETO HARAS
# =============================================================================

output "haras_user_access_key_id" {
  description = "Access Key ID do usuário IAM completo do Haras"
  value       = module.haras.haras_complete_user_access_key_id
}

output "haras_complete_user_secret_access_key" {
  description = "Secret Access Key do usuário IAM completo do Haras"
  value       = module.haras.haras_complete_user_secret_access_key
  sensitive   = true
}

# =============================================================================
# OUTPUTS DO PROJETO VMPAY
# =============================================================================

output "vmpay_user_access_key_id" {
  description = "Access Key ID do usuário IAM completo do VMPay"
  value       = module.vmpay.iam_complete_user_access_key_id
}

output "vmpay_complete_user_secret_access_key" {
  description = "Secret Access Key do usuário IAM completo do VMPay"
  value       = module.vmpay.iam_complete_user_secret_access_key
  sensitive   = true
}

# =============================================================================
# OUTPUTS DO PROJETO AUDITORIA
# =============================================================================

output "auditoria_s3_bucket_name" {
  description = "Nome do bucket S3 do Auditoria frontend"
  value       = module.auditoria.s3_bucket_name
}

output "auditoria_cloudfront_url" {
  description = "URL HTTPS do CloudFront para o Auditoria"
  value       = module.auditoria.cloudfront_url
}

output "auditoria_cloudfront_domain" {
  description = "Domínio CloudFront para o Auditoria"
  value       = module.auditoria.cloudfront_domain_name
}

# =============================================================================
# OUTPUTS DO PROJETO PGRS
# =============================================================================

output "pgrs_s3_bucket_name" {
  description = "Nome do bucket S3 do PGRs frontend"
  value       = module.pgrs.s3_bucket_name
}

output "pgrs_cloudfront_url" {
  description = "URL HTTPS do CloudFront para o PGRs"
  value       = module.pgrs.cloudfront_url
}

output "pgrs_cloudfront_domain" {
  description = "Domínio CloudFront para o PGRs"
  value       = module.pgrs.cloudfront_domain_name
}

# =============================================================================
# OUTPUTS DO PROJETO SOCIAL
# =============================================================================

output "social_s3_bucket_name" {
  description = "Nome do bucket S3 para o Social"
  value       = module.social.s3_bucket_name
}

output "social_cloudfront_url" {
  description = "URL do CloudFront para o Social"
  value       = module.social.cloudfront_url
}

output "social_cloudfront_domain" {
  description = "Domínio CloudFront para o Social"
  value       = module.social.cloudfront_domain_name
}

