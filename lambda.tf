
resource "aws_lambda_function" "aws_connect_lookup" {
  filename         = "lambda.zip"
  function_name    = "aws_connect_lookup"
  handler          = "index.handler"
  role             = "${aws_iam_role.aws_lambda_dynamo_admin_role.arn}"
  runtime          = "nodejs12.04"
  source_code_hash = "${filebase64sha256("lambda.zip")}"
}