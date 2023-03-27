terraform {
  backend "s3" {
    bucket         = "gb-crc-terraform-state"
    key            = "back-end/terraform.tfstate"
    region         = var.region
    dynamodb_table = "terraform-lock"
    encrypt        = true
  }
}

provider "aws" {
  region = var.region
}
