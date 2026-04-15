variable "project" {
  description = "Nome do projeto"
  type        = string
  default     = "helpdesk"
}

variable "environment" {
  description = "Ambiente"
  type        = string
  default     = "production"
}

# Variáveis para os recursos
variable "s3_bucket_name" {
  description = "Nome do bucket S3"
  type        = string
}

variable "ecr_repo_name" {
  description = "Nome do repositório ECR"
  type        = string
  default     = "helpdesk-image-repo"
}

variable "cloudfront_distribution_id" {
  description = "ID da distribuição CloudFront"
  type        = string
}