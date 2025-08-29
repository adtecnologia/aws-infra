# Bucket privado para armazenar arquivos do UGO APP
resource "aws_s3_bucket" "ugo_private" {
  bucket = "ugo-private"
  region = var.region.brasil

  tags = {
    name = "ugo-private"
    env  = "prod"
  }
}

#