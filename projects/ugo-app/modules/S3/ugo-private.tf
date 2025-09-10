# Bucket privado para armazenar arquivos do UGO APP
resource "aws_s3_bucket" "ugo_private" {
  bucket = "ugo-private"

  tags = {
    name = "ugo-private"
    env  = "prod"
  }
}
