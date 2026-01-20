terraform {
    backend "s3" {
    bucket = "my-terraform-state-bucket-learningtf"
    key    = "dev/statefiles/terraform.tfstate"
    region = "us-east-1"
    encrypt = true
    use_lockfile = true

  }
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 6.0"
    }
  }
}

provider "aws" {
    region = "us-east-1"
}

resource "aws_s3_bucket" "first_bucket" {
  bucket = "ganis-tf-test-bucket-1234567890"

  tags = {
    Name        = "My Test Bucket"
    Environment = "Test"
  }
}