
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
