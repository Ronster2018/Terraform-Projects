# This scenario shows:
# how to create IAM User, User Groups, Permission Policies, Attachment Policy-User Group
# how to use Count, For_Each, Map



terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}
