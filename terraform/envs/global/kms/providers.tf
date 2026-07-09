terraform {
  required_version = ">= 1.11"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.28"
    }
  }

  backend "s3" {
    bucket       = "eks-sandbox-apne2-tfstate"
    key          = "envs/global/kms/terraform.tfstate"
    region       = "ap-northeast-2"
    use_lockfile = true
  }
}

provider "aws" {
  region = "ap-northeast-2"

  default_tags {
    tags = {
      Project   = "eks-sandbox"
      Owner     = "minyx"
      Terraform = "true"
    }
  }
}