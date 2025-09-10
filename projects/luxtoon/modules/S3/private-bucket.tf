# Bucket privado para armazenar arquivos do Luxtoon
resource "aws_s3_bucket" "luxtoon_private" {
  bucket = "luxtoon-private"

  tags = {
    name = "luxtoon-private"
    env  = "prod"
    projeto = "luxtoon"
  }
}