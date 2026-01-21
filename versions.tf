terraform {
  required_version = ">= 1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket         = "coco-aws-test-bucket"
    key            = "coco-terraform/dev/terraform.tfstate"
    region         = "ap-northeast-1"
    encrypt        = true
    dynamodb_table = "coco-test-table"
    use_lockfile   = true
  }
}

provider "aws" {
  region = var.aws_region
}
