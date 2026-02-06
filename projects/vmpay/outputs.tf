output "iam_complete_user_name" {
  description = "The name of the complete IAM user"
  value       = module.iam.complete_user_name
}

output "iam_complete_user_access_key_id" {
  description = "The access key ID of the complete IAM user"
  value       = module.iam.complete_user_access_key_id
}

output "iam_complete_user_secret_access_key" {
  description = "The secret access key of the complete IAM user"
  value       = module.iam.complete_user_secret_access_key
  sensitive   = true
}

