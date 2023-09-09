variable "instance_type" {
  type        = string
  description = "EC2 Instance Type"
  default     = "t2.micro"
}

variable "tag" {
  type        = string
  description = "The tag for the EC2 instance"
}

variable "location" {
  type        = string
  description = "The project region"
  default     = "us-east-1"
}

variable "availability_zone" {
  type        = string
  description = "The project availability zone"
  default     = "us-east-1a"
}

variable "ami" {
  type        = string
  description = "The project region"
  default     = "ami-053b0d53c279acc90" # Canonical, Ubuntu, 22.04 LTS, amd64 jammy image build on 2023-05-16
}
