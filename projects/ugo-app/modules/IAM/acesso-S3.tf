resource "aws_iam_policy" "s3_bucket_access" {
  name        = "s3-ugo-access"
  description = "permissão de acesso aos buckets do ugo app"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:DeleteObject",
          "s3:ListBucket"
        ],
        Resource = [
          "arn:aws:s3:::ugo-private",
          "arn:aws:s3:::ugo-private/*",
          "arn:aws:s3:::ugo-private-dev",
          "arn:aws:s3:::ugo-private-dev/*",
          "arn:aws:s3:::ugo-adm-front",
          "arn:aws:s3:::ugo-adm-front/*"
        ]
      }
    ]
  })
}