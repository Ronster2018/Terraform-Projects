# Data sources are used to retrieve/fatch/get data from previously created clour objects and resourcescheck.

# Filter: used to filter through the existing objects, resources, instances, etc.
# "depends_on" run the data block after the resource is created
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

resource "aws_instance" "my_ec2_instance" {
  ami           = var.ami
  instance_type = var.instance_type

  tags = {
    Name = var.ec2_tag_name
  }
}


#filter/select the existed instance
# depends_on if aws_instance.instance is created

data "aws_instance" "data_instance" {
  filter {
    name   = "tag:Name"
    values = [var.ec2_tag_name]
  }

  depends_on = [aws_instance.my_ec2_instance]
}


output "instance_info" {
  value = data.aws_instance.data_instance
}

output "instance_public_ip" {
  value = data.aws_instance.data_instance.public_ip
}
