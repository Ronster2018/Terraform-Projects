# This scenario shows:
# - How to create IAM User, User Groups, Permission Policies, Attachment Policy-User Group
# - How to use Count, For_Each, Map

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

# --- User - User group attachment ( with index count)
resource "aws_iam_user_group_membership" "user1_group_atttach" {
  user = aws_iam_user.user_example[0].name

  groups = [
    aws_iam_group.admin_group.name,
    aws_iam_group.dev_group.name,
  ]
}

resource "aws_iam_user_group_membership" "user2_group_atttach" {
  user = aws_iam_user.user_example[1].id
  groups = [
    aws_iam_group.admin_group.name
  ]
}


resource "aws_iam_user_group_membership" "user3_group_attach" {
  user = aws_iam_user.user_example[2].name

  groups = [
    aws_iam_group.dev_group.name
  ]
}

# --- User Group Definition
resource "aws_iam_group" "admin_group" {
  name = "admin_group"
}

resource "aws_iam_group" "dev_group" {
  name = "dev_group"
}

# --- Policy Definition & Policy Group Attachment
data "aws_iam_policy_document" "admin_policy" {
  statement {
    effect    = "Allow"
    actions   = ["*"]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "admin_policy" {
  name        = "admin-policy"
  description = "Admin Policy"
  policy      = data.aws_iam_policy_document.admin_policy.json
}

data "aws_iam_policy_document" "ec2_policy" {
  statement {
    effect    = "Allow"
    actions   = ["ec2:Describe*"]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "ec2_policy" {
  name        = "ec2-policy"
  description = "Ec2 Policy"
  policy      = data.aws_iam_policy_document.ec2_policy.json
}

# --- Poliucy Attachment to the Admin, Dev Group
resource "aws_iam_group_policy_attachment" "admin_group_admin_policy_attach" {
  group      = aws_iam_group.admin_group.name
  policy_arn = aws_iam_policy.admin_policy.arn
}

resource "aws_iam_group_policy_attachment" "dev_group_ec2_policy_attach" {
  group      = aws_iam_group.dev_group.name
  policy_arn = aws_iam_policy.ec2_policy.arn
}

# --- Username Definition with Count
resource "aws_iam_user" "user_example" {
  /*Count deals with a set number (1,2,3...) and creates an *ordered list*. If it changes, the resource changes.

  Useful if you dont need to refer to the list of objects somewhere else.
  Useful if your input is a simple integer
  Useful if you're doing conditional creation.
  Ex:

  locals {
    create_resource = true
  }
  count = local.create_resource ? 1:0 | if true, create one. Else, create none.
  */
  count = length(var.user_names)
  name  = var.user_names[count.index]
}

# Count, use list
variable "user_names" {
  description = "IAM usernames"
  type        = list(string)
  default     = ["username1_admin_dev", "username2_admin", "username3_dev_ec2"]
}

# With for loop
output "print_the_names" {
  value = [for name in var.user_names : name]
}
