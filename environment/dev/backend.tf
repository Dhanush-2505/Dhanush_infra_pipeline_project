terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.67.0"                # Specify the version of the AWS provider to use
    }
  }
  backend "s3" {
    bucket = "mt-terra-buc"
    key    = "environments/dev/terraform.tfstate"
    region = "ap-south-1"
  }
}

provider "aws" {
  region = var.aws_region
}