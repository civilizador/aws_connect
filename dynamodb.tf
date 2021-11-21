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
    name = "name"
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
    non_key_attributes = ["name"]
  }

}