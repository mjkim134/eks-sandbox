terraform {
    required_version = ">= 1.11"

    required_providers {
        aws = {
            source  = "hashicorp/aws"
            version = "~> 6.28"
        }
    }
}

provider "aws" {
    region = "ap-northeast-2"
}

resource "aws_s3_bucket" "tfstate" {
    bucket = "kimpala-id-tfstate"
}

resource "aws_s3_bucket_versioning" "tfstate" {
    bucket = aws_s3_bucket.tfstate.id

    versioning_configuration {
        status = "Enabled"
    }
}