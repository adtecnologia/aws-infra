# Bucket para armazenar o frontend do Auditoria
resource "aws_s3_bucket" "auditoria_front" {
  bucket = "auditoria-front"

  tags = {
    name = "auditoria-front"
    env  = "prod"
  }
}

# Configuração de website para o bucket (necessária para SPA routing via CloudFront)
resource "aws_s3_bucket_website_configuration" "auditoria_front" {
  bucket = aws_s3_bucket.auditoria_front.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "index.html"
  }
}