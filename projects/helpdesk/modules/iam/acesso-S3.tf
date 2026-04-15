# Política de acesso ao S3 para o Helpdesk
resource "aws_iam_policy" "s3_bucket_access" {
  name        = "helpdesk-s3-access"
  description = "Política de acesso ao S3 para o projeto helpdesk"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:DeleteObject",
          "s3:ListBucket"
        ]
        Resource = [
          "arn:aws:s3:::${var.s3_bucket_name}",
          "arn:aws:s3:::${var.s3_bucket_name}/*"
        ]
      }
    ]
  })
}