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
