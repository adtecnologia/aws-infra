# Bucket para armazenar o frontend do Care
resource "aws_s3_bucket" "care_front" {
  bucket = "care-front"

  tags = {
    name = "care-front"
    env  = "prod"
  }
}

# Configuração de website para o bucket (necessária para SPA routing via CloudFront)
resource "aws_s3_bucket_website_configuration" "care_front" {
  bucket = aws_s3_bucket.care_front.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "index.html"
  }
}