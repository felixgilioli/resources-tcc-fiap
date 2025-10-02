terraform {
  required_version = ">= 1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.94.1"
    }
  }

  backend "s3" {
    bucket         = "iac-tcc-felix"
    key            = "fastfood/rds/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "tcc-locks"
  }
}

provider "aws" {
  region = var.region

  default_tags {
    tags = var.tags
  }
}

# Módulo de Networking
module "networking" {
  source = "./modules/networking"

  project_name = var.project_name
  vpc_cidr     = var.vpc_cidr

  availability_zones = var.availability_zones
  public_subnet_cidrs = var.public_subnet_cidrs

  tags = var.tags
}

# Módulo de RDS
module "rds" {
  source = "./modules/rds"

  db_name     = var.db_name
  db_username = var.db_username
  db_password = var.db_password

  vpc_id             = module.networking.vpc_id
  subnet_ids         = module.networking.public_subnet_ids
  security_group_ids = [module.networking.rds_security_group_id]

  instance_class          = var.instance_class
  allocated_storage       = var.allocated_storage
  max_allocated_storage   = var.max_allocated_storage
  backup_retention_period = var.backup_retention_period
  skip_final_snapshot     = var.skip_final_snapshot
  publicly_accessible     = var.publicly_accessible

  tags = var.tags
}