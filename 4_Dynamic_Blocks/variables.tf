variable "instance_type" {
  type        = string
  description = "EC2 Instance Type"
  default     = "t2.micro"
}

variable "tag" {
  type        = string
  description = "The tag for the EC2 Instance"
}

variable "location" {
  type        = string
  description = "The project Region"
  default     = "us-east-1"
}

variable "availability_zone" {
  type        = string
  description = "The project availability zone"
  default     = "us-east-1c"
}

variable "ami" {
  type        = string
  description = "The Project Region"
}
