# CloudFront Origin Access Control (OAC)
resource "aws_cloudfront_origin_access_control" "helpdesk" {
  name                              = "helpdesk-oac"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

# CloudFront Distribution para o front-end helpdesk
resource "aws_cloudfront_distribution" "helpdesk" {
  enabled             = true
  price_class         = "PriceClass_All"
  comment             = "helpdesk Frontend"
  default_root_object = "index.html"

  origin {
    domain_name = var.s3_bucket_domain_name
    origin_id   = "helpdesk-origin"

    origin_access_control_id = aws_cloudfront_origin_access_control.helpdesk.id
  }

  default_cache_behavior {
    allowed_methods        = ["GET", "HEAD", "OPTIONS"]
    cached_methods         = ["GET", "HEAD"]
    target_origin_id       = "helpdesk-origin"
    viewer_protocol_policy = "redirect-to-https"
    compress               = true

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }
  }

  # Cache behavior para arquivos estáticos
  ordered_cache_behavior {
    path_pattern           = "/static/*"
    allowed_methods        = ["GET", "HEAD", "OPTIONS"]
    cached_methods         = ["GET", "HEAD"]
    target_origin_id       = "helpdesk-origin"
    viewer_protocol_policy = "redirect-to-https"
    compress               = true

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }
  }

  # Cache behavior para assets
  ordered_cache_behavior {
    path_pattern           = "/assets/*"
    allowed_methods        = ["GET", "HEAD", "OPTIONS"]
    cached_methods         = ["GET", "HEAD"]
    target_origin_id       = "helpdesk-origin"
    viewer_protocol_policy = "redirect-to-https"
    compress               = true

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }

  tags = {
    Name        = "helpdesk CloudFront"
    Project     = "helpdesk"
    Environment = "production"
  }
}