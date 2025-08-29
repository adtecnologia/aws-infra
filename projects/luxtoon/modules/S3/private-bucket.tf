# Bucket privado para armazenar arquivos do UGO APP
resource "aws_s3_bucket" "ugo_private" {
  bucket = "luxtoon-private"
  region = var.region.brasil

  tags = {
    name = "luxtoon-private"
    env  = "prod"
    projeto = "luxtoon"
  }
}