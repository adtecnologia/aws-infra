# Bucket privado para armazenar arquivos do helpdesk
resource "aws_s3_bucket" "helpdesk_private" {
  bucket = "helpdesk-private"

  tags = {
    name = "helpdesk-private"
    env  = "prod"
  }
}