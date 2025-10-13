resource "aws_iam_policy" "cloudfront_access" {
  name        = "cloudfront-ugo-access"
  description = "Permissão de acesso ao CloudFront para invalidações"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "cloudfront:GetDistribution",
          "cloudfront:ListDistributions",
          "cloudfront:CreateInvalidation"
        ]
        Resource = "*"
      }
    ]
  })
}