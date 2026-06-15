terraform {
  required_version = ">= 1.11"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.28"
    }
  }

  backend "s3" {
    bucket         = "kimpala-id-tfstate"
    key            = "terraform/eks/terraform.tfstate"
    region         = "ap-northeast-2"
    use_lockfile   = true
  }
}

provider "aws" {
  region = var.region

  default_tags {
    tags = {
      Service      = "Test"
      Organization = "tech"
      Team         = "tech/devops"
      Resource     = "eks"
      Env          = "dev"
      Terraformed  = "true"
    }
  }
}