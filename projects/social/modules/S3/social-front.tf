# Bucket para armazenar o frontend do Social
resource "aws_s3_bucket" "social_front" {
  bucket = "social-adsolucoes-frontend-prod"

  tags = {
    name = "social-adsolucoes-frontend-prod"
    env  = "prod"
  }
}

# Configuração de website para o bucket (necessária para SPA routing via CloudFront)
resource "aws_s3_bucket_website_configuration" "social_front" {
  bucket = aws_s3_bucket.social_front.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "index.html"
  }
}