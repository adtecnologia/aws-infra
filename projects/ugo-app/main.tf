# Infraestrutura do projeto UGO App

module "CloudFront" {
  source                 = "./modules/CloudFront"
  region                 = var.region
  s3_website_endpoint    = module.S3.s3_website_endpoint
  s3_bucket_name         = module.S3.s3_bucket_name
  s3_bucket_domain_name  = module.S3.s3_bucket_domain_name
  s3_bucket_arn          = module.S3.s3_bucket_arn
}

module "S3" {
  source = "./modules/S3"
  region = var.region
}

module "IAM" {
  source = "./modules/IAM"
}

module "ECR" {
  source = "./modules/ECR"
}