terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.70.0"
    }
  }
  backend "s3" {
    bucket       = "remote-tf-file-dev"
    key          = "sg-rules.tfstate"
    region       = "us-east-1"
    encrypt      = true
    use_lockfile = true

  }

}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}
