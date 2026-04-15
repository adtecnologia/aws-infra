# Get current AWS account ID
data "aws_caller_identity" "current" {}

# S3 Bucket para hospedagem estática do front-end rebucci
resource "aws_s3_bucket" "rebucci_front" {
  bucket = "rebucci-front"

  tags = {
    Name        = "rebucci Frontend"
    Project     = "rebucci"
    Environment = "production"
  }
}

# Configuração de hosting estático
resource "aws_s3_bucket_website_configuration" "rebucci_front" {
  bucket = aws_s3_bucket.rebucci_front.bucket

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "index.html"
  }
}

# Block public access - tudo bloqueado (acesso só via CloudFront)
resource "aws_s3_bucket_public_access_block" "rebucci_front" {
  bucket = aws_s3_bucket.rebucci_front.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Lifecycle policy para limpar versões antigas
resource "aws_s3_bucket_lifecycle_configuration" "rebucci_front" {
  bucket = aws_s3_bucket.rebucci_front.id

  rule {
    id     = "abort-incomplete-multipart-upload"
    status = "Enabled"

    abort_incomplete_multipart_upload {
      days_after_initiation = 7
    }
  }
}
