resource "aws_iam_user" "api" {
  name = "ugo-bucket-api"
}

resource "aws_iam_policy" "s3_bucket_access" {
  name        = "s3-ugo-private-access"
  description = "permissão de acesso ao bucket ugo-private"

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
          "arn:aws:s3:::ugo-private/*"
        ]
      }
    ]
  })
}

# 3. Vincula a política ao usuário
resource "aws_iam_user_policy_attachment" "s3_access" {
  user       = aws_iam_user.api.name
  policy_arn = aws_iam_policy.s3_bucket_access.arn
}