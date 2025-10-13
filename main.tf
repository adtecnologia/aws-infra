terraform {
  required_version = ">= 1.5.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.16.0"
    }
  }
  backend "s3" {
    bucket  = "adsolucoes-terraform"
    key     = "terraform.tfstate"
    region  = "sa-east-1"
    encrypt = true
  }
}

# Configuração do provedor AWS
provider "aws" {
  region = var.region.brasil
}

# Módulo para infraestrutura do UGO App
module "ugo_app" {
  source = "./projects/ugo-app"
  region = var.region
}

# Módulo para infraestrutura do Luxtoon
module "luxtoon" {
  source = "./projects/luxtoon"
  region = var.region
}

# Módulo para infraestrutura do Plane
module "plane" {
  source = "./projects/plane"
  region = var.region
}

# Módulo para infraestrutura do for+
module "forplus" {
  source = "./projects/forplus"
  region = var.region
}

# Módulo para infraestrutura do Petlove
module "petlove" {
  source = "./projects/petlove"
  region = var.region
}