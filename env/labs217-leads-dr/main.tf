provider "aws" {
  region = "${var.region}"
}

provider "alks" {
  url = "https://alks.coxautoinc.com/rest"
}

terraform {
  backend "s3" {
    bucket = "awslabs217-us-east-2-lead-dr-terraform-state"
    key    = "terraform-awslabs217-labs"
    region = "us-east-2"
  }
}

variable "region" {}
variable "key_expiry" {}

module "lead_process" {
  source = "../../modules/leads-process"
}
