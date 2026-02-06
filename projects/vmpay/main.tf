module "ecr" {
  source = "./modules/ECR"
}

module "iam" {
  source = "./modules/IAM"
}
