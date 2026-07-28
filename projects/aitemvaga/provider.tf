terraform {
  required_version = ">= 1.5.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.14.0"
    }
  }
  backend "s3" {
    bucket  = "adsolucoes-terraform"
    key     = "aitemvaga/terraform.tfstate"
    region  = "sa-east-1"
    encrypt = true
    profile = "ad-soluções"
  }
}

# Configuração do provedor AWS
provider "aws" {
  region  = var.region.brasil
  profile = "ad-soluções"
}
