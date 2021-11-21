resource "aws_connect_instance" "connect_instance_1" {
  identity_management_type = "CONNECT_MANAGED"
  inbound_calls_enabled    = true
  instance_alias           = "technical-support"
  outbound_calls_enabled   = true
}