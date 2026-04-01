terraform {
  required_version = ">= 1.5.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.30.0"
    }
  }
  backend "s3" {
    bucket  = "adsolucoes-terraform"
    key     = "terraform.tfstate"
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

# Módulo para infraestrutura do haras
module "haras" {
  source = "./projects/haras"
  region = var.region
}

# Módulo para infraestrutura do vmpay
module "vmpay" {
  source = "./projects/vmpay"
  region = var.region
}

# Módulo para infraestrutura do adflow
module "adflow" {
  source = "./projects/adflow"
  region = var.region
}

# Módulo para infraestrutura do rebucci
module "rebucci" {
  source = "./projects/rebucci"
  region = var.region
}