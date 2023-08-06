# Key-pair for log server
resource "aws_key_pair" "aws_log_server_key" {
  key_name   = "aws_log_server_key"
  public_key = file(var.PATH_TO_LOG_SERVER_PUBLIC_KEY)
}
