/*
Workspace
- A parellel and distict copy of your infrastructure wher you can test and verify in development, test, and staging.
- Similar to git, you are working on different workspaces (branches)
- Signle code but different workspaces
- Creates multiple state files on different workspace diractories

Create a new workspace via the cli
terraform workspace ls
terraform workspace new dev
terraform workspace new prod
terraform workspace show
terraform workspace select dev
terraform init

# Create the infrastructure in the Dev workspace
terraform plan --var-file="dev.tfvars"
terraform apply --var-file="dev.tfvars"

# Switch to the prod workspace and create the infrastructure there too
terraform workspace select prod
terraform plan -var-file="terraform-prod.tfvars"     # run "plan" for test, dry-run
terraform apply -var-file="terraform-prod.tfvars"

# Notice how there are two separate folders under the terraform.tfstate.d folder. Each folder contains a separate state file for the environment.

# Switch back to the Dev environment and tear it down.
terraform workspace select dev
terraform destroy -var-file="terraform-dev.tfvars"

# Do the same for Prod
terraform workspace select prod
terraform destroy -var-file="terraform-prod.tfvars"
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

locals {
  tag = "${terraform.workspace} EC2"
}

resource "aws_instance" "my_instance_22_04" {
  ami = "ami-053b0d53c279acc90" # Canonical, Ubuntu, 22.04 LTS, amd64 jammy image build on 2023-05-16

  instance_type = "t2.micro"
  tags = {
    Name = local.tag
  }
}
