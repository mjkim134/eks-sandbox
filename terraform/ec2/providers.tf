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
    key            = "ec2/terraform.tfstate"
    region         = "ap-northeast-2"
    use_lockfile   = true
  }
}

provider "aws" {
  region = "ap.northeast-2"

  default_tags {
    tags = {
      Service      = "Teamcity"
      Organization = "tech"
      Team         = "tech/devops"
      Resource     = "ec2"
      Env          = "dev"
      Terraformed  = "true"
      User         = "kimpala"
    }
  }
}