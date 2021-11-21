# Creating a VPC
resource "aws_vpc" "aws_connect" {
  cidr_block = "10.0.0.0/16"
}
