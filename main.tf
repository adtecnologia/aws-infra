terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  backend "s3" {
    bucket  = "adsolucoes-terraform"
    key     = "terraform.tfstate"
    region  = "sa-east-1"
    encrypt = true
  }
}

provider "aws" {
  region = var.region.brasil
}

module "ugo-app" {
  source = "./projects/ugo-app"
  region = var.region
}

module "luxtoon" {
  source = "./projects/luxtoon"
  region = var.region 
}

module "plane" {
  source = "./projects/plane"
  region = var.region
}