terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 3.11"
    }
  }
}
#test
provider "aws" {
  region = var.region
}

module "storage" {
  source = "./modules/storage"
}
