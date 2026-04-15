# Política de acesso ao CloudFront para o Helpdesk
resource "aws_iam_policy" "cloudfront_access" {
  name        = "helpdesk-cloudfront-access"
  description = "Política de acesso ao CloudFront para o projeto helpdesk"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "cloudfront:GetDistribution",
          "cloudfront:GetDistributionConfig",
          "cloudfront:ListInvalidations",
          "cloudfront:CreateInvalidation"
        ]
        Resource = "arn:aws:cloudfront::${data.aws_caller_identity.current.account_id}:distribution/${var.cloudfront_distribution_id}"
      }
    ]
  })
}

data "aws_caller_identity" "current" {}