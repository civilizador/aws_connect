terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  access_key = var.AWS_ACCESS_KEY_ID
  secret_key = var.AWS_SECRET_ACCESS_KEY
  region     = var.AWS_REGION
}

# Create a VPC
resource "aws_vpc" "aws_connect" {
  cidr_block = "10.0.0.0/16"
}

# RETRIEVE IAM POLICY for the Lambda function.
data "aws_iam_policy_document" "AWSLambdaTrustPolicy" {
  statement {
    actions    = ["sts:AssumeRole"]
    effect     = "Allow"
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

# Create IAM ROLE for the Lambda function. 
resource "aws_iam_role" "aws_lambda_dynamo_admin_role" {
  name               = "terraform_function_role"
  assume_role_policy = "${data.aws_iam_policy_document.AWSLambdaTrustPolicy.json}"
}

# Role policy  
resource "aws_iam_policy" "admin_policy_lambda" {
  name        = "admin_policy_lambda"
  path        = "/"
  description = "IAM POLICY TO ALLOW ADMIN ACCESS TO DYNAMO DB FOR LAMBDA"
  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "ReadWriteTable",
            "Effect": "Allow",
            "Action": [
                "dynamodb:BatchGetItem",
                "dynamodb:GetItem",
                "dynamodb:Query",
                "dynamodb:Scan",
                "dynamodb:BatchWriteItem",
                "dynamodb:PutItem",
                "dynamodb:UpdateItem"
            ],
            "Resource": "*"
        },
        {
            "Sid": "GetStreamRecords",
            "Effect": "Allow",
            "Action": "dynamodb:GetRecords",
            "Resource": "*"
        },
        {
            "Sid": "WriteLogStreamsAndGroups",
            "Effect": "Allow",
            "Action": [
                "logs:CreateLogStream",
                "logs:PutLogEvents"
            ],
            "Resource": "*"
        },
        {
            "Sid": "CreateLogGroup",
            "Effect": "Allow",
            "Action": "logs:CreateLogGroup",
            "Resource": "*"
        }
    ]
})
}

resource "aws_iam_role_policy_attachment" "test-attach" {
  role       = aws_iam_role.aws_lambda_dynamo_admin_role.name
  policy_arn = aws_iam_policy.admin_policy_lambda.arn
}

# resource "aws_lambda_function" "customer_lookup" {
#   filename         = "terraform_function.zip"
#   function_name    = "terraform_function"
#   handler          = "index.handler"
#   role             = "${aws_iam_role.terraform_function_role.arn}"
#   runtime          = "nodejs8.10"
#   source_code_hash = "${filebase64sha256("terraform_function.zip")}"
# }
