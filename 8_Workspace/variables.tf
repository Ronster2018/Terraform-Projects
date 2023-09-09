variable "instance_type" {
  type        = string
  description = "EC2 Instance Type"
}

variable "location" {
  type        = string
  description = "The Project Region"
  default     = "us-east-1"
}

variable "ami" {
  type        = string
  description = "The Instance AMI ID"
}
