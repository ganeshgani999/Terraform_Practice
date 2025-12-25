terraform {
  backend "s3" {
    bucket         = "my-terraform-state-bucket-learningtf"
    key            = "test/s3-demo/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
  }
}
