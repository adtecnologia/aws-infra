# Outputs da infraestrutura completa

# =============================================================================
# OUTPUTS DO PROJETO UGO-APP
# =============================================================================

output "ugo_app_user_access_key_id" {
  description = "Access Key ID do usuário IAM completo do UGO App"
  value       = module.ugo-app.ugo_complete_user_access_key_id
}

output "ugo_app_complete_user_secret_access_key" {
  description = "Secret Access Key do usuário IAM completo do UGO App"
  value       = module.ugo-app.ugo_complete_user_secret_access_key
  sensitive   = true
}

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
