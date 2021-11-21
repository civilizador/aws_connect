
# Configuring the terraform provider
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

# Configuring the AWS Provider
provider "aws" {
  access_key = var.AWS_ACCESS_KEY_ID
  secret_key = var.AWS_SECRET_ACCESS_KEY
  region     = var.AWS_REGION
}

# Creating a VPC
resource "aws_vpc" "aws_connect" {
  cidr_block = "10.0.0.0/16"
}

# Create IAM ROLE for the Lambda function. 
resource "aws_iam_role" "aws_lambda_dynamo_admin_role" {
  name               = "terraform_function_role"
  assume_role_policy =  file("policies/assume_role_policy.json")
}

# Creating an IAM policy for Lambda function
resource "aws_iam_role_policy" "lambda_policy" {
  name = "lambda_policy"
  role = aws_iam_role.aws_lambda_dynamo_admin_role.id
  policy = file("policies/policy.json")
}
