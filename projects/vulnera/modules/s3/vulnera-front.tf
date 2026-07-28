# Get current AWS account ID
data "aws_caller_identity" "current" {}

# S3 Bucket para hospedagem estática do front-end vulnera
resource "aws_s3_bucket" "vulnera_front" {
  bucket = "vulnera-front"

  tags = {
    Name        = "vulnera Frontend"
    Project     = "vulnera"
    Environment = "production"
  }
}

# Configuração de hosting estático
resource "aws_s3_bucket_website_configuration" "vulnera_front" {
  bucket = aws_s3_bucket.vulnera_front.bucket

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "index.html"
  }
}

# Block public access - tudo bloqueado (acesso só via CloudFront)
resource "aws_s3_bucket_public_access_block" "vulnera_front" {
  bucket = aws_s3_bucket.vulnera_front.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Lifecycle policy para limpar versões antigas
resource "aws_s3_bucket_lifecycle_configuration" "vulnera_front" {
  bucket = aws_s3_bucket.vulnera_front.id

  rule {
    id     = "abort-incomplete-multipart-upload"
    status = "Enabled"

    abort_incomplete_multipart_upload {
      days_after_initiation = 7
    }
  }
}