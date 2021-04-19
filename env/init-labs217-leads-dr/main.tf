provider "aws" {
  region = "us-east-2"
}

resource "aws_s3_bucket" "terraform_state_bucket" {
  bucket = "awslabs217-us-east-2-lead-dr-terraform-state"
  acl    = "private"
}