#Bucket privado para armazenar arquivos do UGO APP no ambiente de desenvolvimento
resource "aws_s3_bucket" "ugo_dev" {
  bucket = "ugo-private-dev"

  tags = {
    name = "ugo-private-dev"
    env  = "dev"
  }
}
