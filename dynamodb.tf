resource "aws_dynamodb_table" "aws_connect_DDB" {
  name             = "contactDetails"
  hash_key         = "phoneNumber"
  range_key        = "lastName"
  billing_mode   = "PROVISIONED"
  read_capacity  = 5
  write_capacity = 5
  attribute {
    name = "phoneNumber"
    type = "S"
  }
  attribute {
    name = "lastName"
    type = "S"
  }
  attribute {
    name = "email"
    type = "S"
  }
  global_secondary_index {
    name               = "LastNameIndex"
    hash_key           = "lastName"
    range_key          = "email"
    write_capacity     = 10
    read_capacity      = 10
    projection_type    = "INCLUDE"
  }

}