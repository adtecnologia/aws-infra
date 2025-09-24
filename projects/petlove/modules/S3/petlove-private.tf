# Bucket privado para armazenar arquivos do PETLOVE
resource "aws_s3_bucket" "petlove_private" {
  bucket = "petlove-private"

  tags = {
    name    = "petlove-private"
    env     = "prod"
    projeto = "petlove"
  }
}
