variable "ami" {
  type        = string
  description = "The ami ID string"
  default     = "ami-051f7e7f6c2f40dc1" # Amazon Linux 2023 AMI 2023.1.20230825.0 x86_64 HVM kernel-6.1
}

variable "instance_type" {
  type        = string
  description = "The EC2 Instance Type"
  default     = "t2.micro"
}

variable "ec2_tag_name" {
  type        = string
  description = "EC2 Instance Tag"
  default     = "SandBox EC2"
}

variable "key_name" {
  type        = string
  description = "Secret Key used for EC2 instances"
  default     = "default-key-pair"
}
