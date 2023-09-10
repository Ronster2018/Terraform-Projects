/*
Backend State Management
- Enabling remote state files using the backend block allows multiple users to work on the same state file.
- We are able to save the common state file in an S3 Bucket.

- Create your S3 Bucket first - "terraform-state"
terraform init
terraform validate
terraform plan
terraform apply

- We can pull the state file from the remote location
terraform state pull > terraform.tfstate

*/

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.16"
    }
  }

  required_version = ">=1.2.0"

  backend "s3" {
    bucket = "terraform-state"
    key    = "key/terraform.tfstate"
    region = "us-east-1"
  }

}

provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "instance" {
  ami           = "ami-053b0d53c279acc90" # Canonical, Ubuntu, 22.04 LTS, amd64 jammy
  instance_type = "t2.nano"

  tags = {
    Name = "Basic Instance"
  }
}
