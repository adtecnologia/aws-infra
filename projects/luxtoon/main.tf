# Infraestrutura do projeto Luxtoon

module "S3" {
  source = "./modules/S3"
  region = var.region
}

module "IAM" {
  source = "./modules/IAM"
}