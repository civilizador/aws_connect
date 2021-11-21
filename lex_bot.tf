
resource "awsconnect_instance_lex_bot" "lex_bot_1" {
  instance_id    = awsconnect_instance.connect_instance_1.instance_id
  lex_bot_region = "us-east-1"
  lex_bot_name   = "LexBotForConnectInstance1"
}