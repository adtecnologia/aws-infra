# Origin Access Control para restringir acesso direto ao S3
resource "aws_cloudfront_origin_access_control" "ugo_adm_front" {
  name                              = "ugo-adm-front-oac"
  description                       = "Origin Access Control for UGO Admin Frontend"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

# CloudFront Distribution para o UGO Admin Frontend
resource "aws_cloudfront_distribution" "ugo_adm_front" {
  origin {
    domain_name              = var.s3_bucket_domain_name
    origin_id                = "S3-${var.s3_bucket_name}"
    origin_access_control_id = aws_cloudfront_origin_access_control.ugo_adm_front.id
  }

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "CloudFront distribution para UGO Admin Frontend"
  default_root_object = "index.html"

  aliases = ["ugo-admin.adsolucoestecnologia.com.br"]

  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "S3-${var.s3_bucket_name}"

    forwarded_values {
      query_string = false
      headers      = ["Cache-Control", "ETag"] # Respeita headers de cache do S3
      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 300  # 5 minutos (para desenvolvimento)
    max_ttl                = 3600 # 1 hora máximo
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

  # Classe de preço mais barata - apenas América do Norte, Europa e Ásia
  # PriceClass_100: Apenas EUA, Canadá e Europa (mais barato)
  # PriceClass_200: EUA, Canadá, Europa, Ásia, Oriente Médio e África 
  # PriceClass_All: Todas as regiões (mais caro)
  price_class = "PriceClass_100"

  # Restrições geográficas - pode restringir por países
  restrictions {
    geo_restriction {
      restriction_type = "whitelist"
      locations        = ["BR"] # Apenas Brasil
    }
  }

  viewer_certificate {
    acm_certificate_arn      = aws_acm_certificate.ugo_adm_front.arn
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1.2_2021"
  }
  depends_on = [aws_acm_certificate_validation.ugo_adm_front]

  tags = {
    name = "ugo-adm-front-cdn"
    env  = "prod"
  }
}

# Configuração de acesso PRIVADO para o bucket (só CloudFront pode acessar)
resource "aws_s3_bucket_public_access_block" "ugo_adm_front_private" {
  bucket = var.s3_bucket_name

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Política do bucket S3 para permitir apenas acesso via CloudFront OAC
resource "aws_s3_bucket_policy" "ugo_adm_front_cloudfront_only" {
  bucket     = var.s3_bucket_name
  depends_on = [aws_s3_bucket_public_access_block.ugo_adm_front_private]

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
            "AWS:SourceArn" = aws_cloudfront_distribution.ugo_adm_front.arn
          }
        }
      }
    ]
  })
}


# Certificado SSL para domínio customizado (CRIAR NA us-east-1)
resource "aws_acm_certificate" "ugo_adm_front" {
  domain_name       = "ugo-admin.adsolucoestecnologia.com.br"
  validation_method = "DNS"
  region            = "us-east-1"

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    name = "ugo-adm-front-ssl"
    env  = "prod"
  }
}

resource "aws_acm_certificate_validation" "ugo_adm_front" {
  certificate_arn         = aws_acm_certificate.ugo_adm_front.arn
  region                  = "us-east-1"
  validation_record_fqdns = ["_54d7b9ad7348ae3b5979f4fa86519522.ugo-admin.adsolucoestecnologia.com.br."] # Preencha manualmente se não usar Route53
}
