# Bucket para armazenar o frontend do PGRs
resource "aws_s3_bucket" "pgrs_front" {
  bucket = "pgrs-front"

  tags = {
    name = "pgrs-front"
    env  = "prod"
  }
}

# Configuração de website para o bucket (necessária para SPA routing via CloudFront)
resource "aws_s3_bucket_website_configuration" "pgrs_front" {
  bucket = aws_s3_bucket.pgrs_front.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "index.html"
  }
}