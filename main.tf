# Configuração principal do Terraform para infraestrutura AWS
# Este arquivo gerencia múltiplos projetos através de módulos

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.12"
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
module "ugo-app" {
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