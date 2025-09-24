# Bucket privado para armazenar arquivos do For+
resource "aws_s3_bucket" "forplus_private" {
  bucket = "forplus-private"

  tags = {
    name = "forplus-private"
    env  = "prod"
  }
}