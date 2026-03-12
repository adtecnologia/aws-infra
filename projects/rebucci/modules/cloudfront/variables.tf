# Variables for CloudFront module

variable "s3_website_endpoint" {
  description = "S3 website endpoint do bucket"
  type        = string
}

variable "s3_bucket_name" {
  description = "Nome do bucket S3"
  type        = string
}

variable "s3_bucket_domain_name" {
  description = "Domain name do bucket S3 (regional)"
  type        = string
}

variable "s3_bucket_arn" {
  description = "ARN do bucket S3"
  type        = string
}

variable "region" {
  description = "Região AWS"
  type        = map(string)
}

# Variáveis para configuração do domínio customizado (opcional)
variable "custom_domain" {
  description = "Domínio customizado para o frontend (ex: admin.seudominio.com)"
  type        = string
  default     = ""
}

variable "route53_zone_id" {
  description = "Zone ID do Route53 para o domínio"
  type        = string
  default     = ""
}
