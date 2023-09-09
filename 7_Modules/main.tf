/*
- This is the structure for multiple resources that are used together.
- Each modules usualy have their own variables.tf that is configured from the parent tf file.
- We make different modules for different components like VPC, IAM, SG, EKS, etc...

- With modules, it helps:
    organize configuration
    encapsulation
    re-usability
    consistency
*/

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.16"
    }
  }

  required_version = ">=1.2.0"
}

provider "aws" {
  region = "us-east-1"
}

module "Webserver-1" {
  source = "./module1"

  instance_type     = "t2.micro"
  tag               = "Webserver 1 Module1 - 20.04"
  location          = "us-east-1"
  availability_zone = "us-east-1a"
  ami               = "ami-053b0d53c279acc90" # Canonical, Ubuntu, 22.04 LTS, amd64 jammy image build on 2023-05-16
}

module "Webserver-2" {
  source = "./module2"

  instance_type     = "t2.micro"
  tag               = "Webserver 2 Module1 - 20.04"
  location          = "us-east-1"
  availability_zone = "us-east-1a"
  ami               = "ami-053b0d53c279acc90" # Canonical, Ubuntu, 22.04 LTS, amd64 jammy image build on 2023-05-16
}
