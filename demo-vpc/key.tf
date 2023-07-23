# Key-pair for web server machine
resource "aws_key_pair" "aws_web_server_key" {
  key_name   = "aws_web_server_key"
  public_key = file(var.PATH_TO_WEB_SERVER_PUBLIC_KEY)
}

# Key-pair for local user
resource "aws_key_pair" "aws_db_server_key" {
  key_name   = "aws_db_server_key"
  public_key = file(var.PATH_TO_DB_SERVER_PUBLIC_KEY)
}


# Key-pair for local user
resource "aws_key_pair" "aws_log_server_key" {
  key_name   = "aws_log_server_key"
  public_key = file(var.PATH_TO_LOG_SERVER_PUBLIC_KEY)
}
