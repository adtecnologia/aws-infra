#Bucket para armazenar o frontend da pagina administrativa do UGO APP
resource "aws_s3_bucket" "ugo_adm_front" {
  bucket = "ugo-adm-front"

  tags = {
    name = "ugo-adm-front"
    env  = "prod"
  }
}

# Configuração de website para o bucket (ainda necessária para SPA routing via CloudFront)
resource "aws_s3_bucket_website_configuration" "ugo_adm_front" {
  bucket = aws_s3_bucket.ugo_adm_front.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "index.html"
  }
}
