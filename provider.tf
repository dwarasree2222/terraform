terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.47.0"
    }
  }
  backend "s3" {
    bucket = "myawsbucketsdwara"
    key    = "path/to/my/key"
    region = "us-east-1"
  }

}


provider "aws" {
  region = var.vpc-subnet-info.region
}