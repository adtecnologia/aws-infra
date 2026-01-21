# Bucket privado para armazenar arquivos do Haras
resource "aws_s3_bucket" "haras_private" {
  bucket = "haras-private"

  tags = {
    name = "haras-private"
    env  = "prod"
  }
}
