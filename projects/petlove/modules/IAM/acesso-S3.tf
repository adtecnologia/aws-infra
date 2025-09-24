resource "aws_iam_policy" "s3_bucket_access" {
  name        = "s3-petlove-private-access"
  description = "permissão de acesso ao bucket petlove-private"

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
          "arn:aws:s3:::petlove-private",
          "arn:aws:s3:::petlove-private/*",
          "arn:aws:s3:::petlove-web",
          "arn:aws:s3:::petlove-web/*"
        ]
      }
    ]
  })
}