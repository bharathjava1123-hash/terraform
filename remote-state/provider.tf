terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.66.0"
    }    
  }

   backend "s3" {
    bucket = "kumar-remote-state"
    key    = "kumar-state-demo"
    region = "us-east-1"
    dynamodb_table = "kumar-locking"
  }
}

provider "aws" {
  # Configuration options
  region = "us-east-1"
}