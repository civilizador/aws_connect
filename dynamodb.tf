resource "aws_dynamodb_table" "aws_connect_DDB" {
  name             = "contactDetails"
  hash_key         = "phoneNumber"
  billing_mode   = "PROVISIONED"
  read_capacity  = 5
  write_capacity = 5
  attribute {
    name = "phoneNumber"
    type = "S"
  }
  attribute {
    name = "Name"
    type = "S"
  }
  attribute {
    name = "lastName"
    type = "S"
  }

}