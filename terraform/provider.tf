terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.60.0"
    }
  }
  backend "s3" {
    bucket         = "terraformremotebackendjune23"
    key            = "nop/terraform"
    dynamodb_table = "terraformstatelock"
    region         = "us-east-1"
  }
}
provider "aws" {
  region = "us-east-1"
}