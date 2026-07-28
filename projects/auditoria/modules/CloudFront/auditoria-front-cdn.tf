# Origin Access Control para restringir acesso direto ao S3
resource "aws_cloudfront_origin_access_control" "auditoria_front" {
  name                              = "auditoria-front-oac"
  description                       = "Origin Access Control for Auditoria Frontend"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

# CloudFront Distribution para o Auditoria Frontend
resource "aws_cloudfront_distribution" "auditoria_front" {
  origin {
    domain_name              = var.s3_bucket_domain_name
    origin_id                = "S3-${var.s3_bucket_name}"
    origin_access_control_id = aws_cloudfront_origin_access_control.auditoria_front.id
  }

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "CloudFront distribution para Auditoria Frontend"
  default_root_object = "index.html"

  aliases = ["auditoria.adsolucoestecnologia.com.br"]

  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "S3-${var.s3_bucket_name}"

    forwarded_values {
      query_string = false
      headers      = ["Cache-Control", "ETag"]
      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 300
    max_ttl                = 3600
    compress               = true
  }

  # Configuração especial para SPAs - redireciona 404s para index.html
  custom_error_response {
    error_code         = 404
    response_code      = 200
    response_page_path = "/index.html"
  }

  custom_error_response {
    error_code         = 403
    response_code      = 200
    response_page_path = "/index.html"
  }

  price_class = "PriceClass_100"

  restrictions {
    geo_restriction {
      restriction_type = "whitelist"
      locations        = ["BR"]
    }
  }

  viewer_certificate {
    acm_certificate_arn      = local.wildcard_cert_arn
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1.2_2021"
  }
}

# Configuração de acesso PRIVADO para o bucket
resource "aws_s3_bucket_public_access_block" "auditoria_front_private" {
  bucket = var.s3_bucket_name

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Política do bucket S3 para permitir apenas acesso via CloudFront OAC
resource "aws_s3_bucket_policy" "auditoria_front_cloudfront_only" {
  bucket     = var.s3_bucket_name
  depends_on = [aws_s3_bucket_public_access_block.auditoria_front_private]

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "AllowCloudFrontServicePrincipal"
        Effect = "Allow"
        Principal = {
          Service = "cloudfront.amazonaws.com"
        }
        Action   = "s3:GetObject"
        Resource = "${var.s3_bucket_arn}/*"
        Condition = {
          StringEquals = {
            "AWS:SourceArn" = aws_cloudfront_distribution.auditoria_front.arn
          }
        }
      }
    ]
  })
}


locals {
  wildcard_cert_arn = "arn:aws:acm:us-east-1:769998260029:certificate/fe608f71-2eae-4bd2-a99d-322a51e24d0c"
}

provider "aws" {
  alias   = "us_east_1"
  region  = "us-east-1"
  profile = "ad-soluções"
}