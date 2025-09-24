# Bucket para website estático do PETLOVE
resource "aws_s3_bucket" "petlove_web" {
  bucket = "petlove-web"

  tags = {
    name    = "petlove-web"
    env     = "web"
    projeto = "petlove"
  }
}

# Configuração de acesso público (necessário para website público)
resource "aws_s3_bucket_public_access_block" "petlove_web" {
  bucket = aws_s3_bucket.petlove_web.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

# Configuração de website estático
resource "aws_s3_bucket_website_configuration" "petlove_web" {
  bucket = aws_s3_bucket.petlove_web.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "index.html"
  }
}

# Política pública para acesso ao website
resource "aws_s3_bucket_policy" "petlove_web_public" {
  bucket = aws_s3_bucket.petlove_web.id
  
  depends_on = [aws_s3_bucket_public_access_block.petlove_web]

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = "*"
        Action = [
          "s3:GetObject"
        ]
        Resource = "${aws_s3_bucket.petlove_web.arn}/*"
      }
    ]
  })
}
