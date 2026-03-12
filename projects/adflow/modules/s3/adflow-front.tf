# Get current AWS account ID
data "aws_caller_identity" "current" {}

# S3 Bucket para hospedagem estática do front-end adflow
resource "aws_s3_bucket" "adflow_front" {
  bucket = "adflow-front"

  tags = {
    Name        = "adflow Frontend"
    Project     = "adflow"
    Environment = "production"
  }
}

# Configuração de hosting estático
resource "aws_s3_bucket_website_configuration" "adflow_front" {
  bucket = aws_s3_bucket.adflow_front.bucket

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "index.html"
  }
}

# Block public access - tudo bloqueado (acesso só via CloudFront)
resource "aws_s3_bucket_public_access_block" "adflow_front" {
  bucket = aws_s3_bucket.adflow_front.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Policy para permitir acesso apenas via CloudFront (OAC)
resource "aws_s3_bucket_policy" "adflow_cloudfront_access" {
  bucket = aws_s3_bucket.adflow_front.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "AllowCloudFrontServicePrincipalReadOnly"
        Effect = "Allow"
        Principal = {
          Service = "cloudfront.amazonaws.com"
        }
        Action   = "s3:GetObject"
        Resource = "${aws_s3_bucket.adflow_front.arn}/*"
        Condition = {
          StringEquals = {
            "aws:SourceArn" : "arn:aws:cloudfront::${data.aws_caller_identity.current.account_id}:distribution/${aws_cloudfront_distribution.adflow.id}"
          }
        }
      }
    ]
  })
}

# Lifecycle policy para limpar versões antigas
resource "aws_s3_bucket_lifecycle_configuration" "adflow_front" {
  bucket = aws_s3_bucket.adflow_front.id

  rule {
    id     = "abort-incomplete-multipart-upload"
    status = "Enabled"

    abort_incomplete_multipart_upload {
      days_after_initiation = 7
    }
  }
}
