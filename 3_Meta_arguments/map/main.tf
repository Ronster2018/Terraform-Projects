# This scenario shows:
# - Map implementation to define usernames

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

#####################################################
# With for_each
/*
    For_each creates a Map object (key:value)
    Useful when you want to refer to the resource somewhere else in the tf file.
    Useful if your input is anything other than an integer
    */
resource "aws_iam_user" "example" {
  for_each = var.user_names
  name     = each.value
}
# With Map
variable "user_names" {
  description = "map"
  type        = map(string)
  default = {
    user1 = "username1"
    user2 = "username2"
    user3 = "username3"
  }
}
# with for loop on map
output "user_with_roles" {
  value = [for name, role in var.user_names : "${name} is the ${role}"]
}
