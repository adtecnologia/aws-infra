#Bucket para armazenar o frontend da pagina administrativa do Haras APP
resource "aws_s3_bucket" "haras_adm_front" {
  bucket = "haras-front"

  tags = {
    name = "haras-front"
    env  = "prod"
  }
}

# Configuração de website para o bucket (ainda necessária para SPA routing via CloudFront)
resource "aws_s3_bucket_website_configuration" "haras_adm_front" {
  bucket = aws_s3_bucket.haras_adm_front.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "index.html"
  }
}
