terraform {
  required_version = ">= 1.11"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.28"
    }
  }

  backend "s3" {
    bucket       = "minist-tfstate"
    key          = "envs/prod/eks/terraform.tfstate"
    region       = "ap-northeast-2"
    use_lockfile = true
  }
}

provider "aws" {
  region = var.region

  default_tags {
    tags = {
      Env       = var.environment
      Project   = var.project
      Owner     = var.owner
      ManagedBy = "Terraform"
    }
  }
}