variable "instance_type_common" {
  type        = string
  description = "AWS Instance Type"
  default     = "t2.micro"
}

variable "default_kp" {
  type        = string
  description = "The default key pair for all instances"
  default     = "default-key-pair"
}
