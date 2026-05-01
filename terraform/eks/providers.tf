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
  key            = "eks/kimpala-dev.tfstate"
  region         = "ap-northeast-2"
  use_lockfile   = true
  }
}

provider "aws" {
  region = local.region
}

data "aws_availability_zones" "available" {
  # Exclude local zones
  filter {
    name   = "opt-in-status"
    values = ["opt-in-not-required"]
  }
}

locals {
  name   = "kimpala-dev"
  region = "ap-northeast-2"
  cluster_version = "1.33"
  vpc_cidr = "10.0.0.0/16"
  azs      = slice(data.aws_availability_zones.available.names, 0, 3)
  secret_hosted_zone_id = "Z07116563LXT0BUDZ2Z8S"

  tags = {
    User = "kimpala"
  }
}