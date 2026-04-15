# Infraestrutura do projeto helpdesk

module "S3" {
  source = "./modules/s3"
  region = var.region
}

module "CloudFront" {
  source                = "./modules/cloudfront"
  region                = var.region
  s3_website_endpoint   = module.S3.s3_website_endpoint
  s3_bucket_name        = module.S3.s3_bucket_name
  s3_bucket_domain_name = module.S3.s3_bucket_domain_name
  s3_bucket_arn         = module.S3.s3_bucket_arn
}

module "ECR" {
  source = "./modules/ecr"
}

module "IAM" {
  source                    = "./modules/IAM"
  s3_bucket_name            = module.S3.s3_bucket_name
  cloudfront_distribution_id = module.CloudFront.cloudfront_distribution_id
}