terraform{
  required_version = ">= 1.3"

required_providers {
  aws = {
    source  = "hashicorp/aws"
  }
  random = {
    source  = "hashicorp/random"
  }  
}
}
provider "aws" {
    region = var.region
}