terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

terraform {
  backend "s3" {
    bucket = "starttech-terraform-state-ayotunde"
    key    = "infra/terraform.tfstate"
    region = "us-east-1"
  }
}

provider "aws" {
  region = var.aws_region
}

module "networking" {
  source = "./modules/networking"

  aws_region  = var.aws_region
  vpc_cidr    = var.vpc_cidr
  environment = var.environment
}


module "eks" {
  source = "./modules/eks"

  cluster_name    = "starttech-cluster"
  cluster_version = var.cluster_version

  environment = var.environment

  vpc_id             = module.networking.vpc_id
  public_subnet_ids  = module.networking.public_subnet_ids
  private_subnet_ids = module.networking.private_subnet_ids

  instance_types = var.instance_types
  desired_size   = var.desired_size
  min_size       = var.min_size
  max_size       = var.max_size
}

module "storage" {
  source = "./modules/storage"

  frontend_bucket_name = var.frontend_bucket_name
  ecr_repository_name  = var.ecr_repository_name

  environment = var.environment

  cloudfront_distribution_arn = module.cdn.cloudfront_distribution_arn

}

module "database" {
  source = "./modules/database"

  redis_name  = var.redis_name
  environment = var.environment

  vpc_id = module.networking.vpc_id

  private_subnet_ids = module.networking.private_subnet_ids

  eks_node_security_group_id = module.eks.node_security_group_id
}

module "cdn" {
  source = "./modules/cdn"

  frontend_bucket_domain_name = module.storage.bucket_regional_domain_name
  frontend_bucket_arn         = module.storage.bucket_arn

  alb_dns_name = var.alb_dns_name

  environment = var.environment
}