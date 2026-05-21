terraform {
  required_version = "~> 1.7"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.28"
    }
  }

  backend "s3" {
  bucket         = "kimpala-tfstate"
  key            = "s3/loki-kimpala-dev.tfstate"
  region         = "ap-northeast-2"
  use_lockfile   = true
  }
}

provider "aws" {
  region = "ap-northeast-2"

  default_tags {
    tags = {
      Service      = "SNS-Test"
      Organization = "tech"
      Team         = "tech/devops"
      Resource     = "s3"
      Env          = "test"
      Terraformed  = "true"
    }
  }
}