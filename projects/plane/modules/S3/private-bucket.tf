# Bucket privado para armazenar arquivos do plane APP
resource "aws_s3_bucket" "plane_private" {
  bucket = "plane-private"

  tags = {
    name = "plane-private"
    env  = "prod"
  }
}

#