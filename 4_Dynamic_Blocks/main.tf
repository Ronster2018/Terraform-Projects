# Dynamic blocks create small code templates that reduce the code repetition.
# Also reduces the need to create parameters for each resource.

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.16.1"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "us-east-1"
}


resource "aws_vpc" "my_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  tags = {
    Name = "My VPC"
  }
}

resource "aws_subnet" "public" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "10.0.0.0/24"
  availability_zone = var.availability_zone
  tags = {
    Name = "Public Subnet"
  }
}


resource "aws_internet_gateway" "my_vpc_igw" {
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    Name = "My VPC - Internet Gateway"
  }
}

resource "aws_route_table" "my_vpc_route_table_us_east_1_public" {
  vpc_id = aws_vpc.my_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_vpc_igw.id
  }

  tags = {
    Name = "Public Subnet Route Table"
  }
}

resource "aws_route_table_association" "my_vpc_us_east_1_public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.my_vpc_route_table_us_east_1_public.id
}

locals {
  ingress_rules = [{
    port        = 22
    description = "Ingress rules for SSH"
    },
    {
      port        = 80
      description = "ingress rules for HTTP"
    },
    {
      port        = 443
      description = "Ingress rules for HTTPS"
  }]
}

resource "aws_security_group" "main" {
  name        = "resource_with_dynamic_block"
  description = "Allow SSH inbound connections"
  vpc_id      = aws_vpc.my_vpc.id

  dynamic "ingress" {
    for_each = local.ingress_rules

    content {
      description = ingress.value.description
      from_port   = ingress.value.port
      to_port     = ingress.value.port
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "AWS security group dynamic block"
  }

}

resource "aws_instance" "ubuntu2204" {
  ami                         = var.ami
  instance_type               = var.instance_type
  key_name                    = "default-key-pair"
  vpc_security_group_ids      = [aws_security_group.main.id]
  subnet_id                   = aws_subnet.public.id
  associate_public_ip_address = true
  tags = {
    Name = var.tag
  }
}

output "instance_ubuntu2204_public_ip" {
  value = aws_instance.ubuntu2204.public_ip
}
