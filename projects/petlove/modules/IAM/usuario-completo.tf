# Usuário IAM com acesso completo aos recursos PETLOVE
resource "aws_iam_user" "petlove_complete_user" {
  name = "petlove-complete-user"
  path = "/"

  tags = {
    Name        = "PETLOVE Complete User"
    Project     = "petlove"
    Environment = "production"
  }
}

# Anexa a política de acesso ao ECR ao usuário completo
resource "aws_iam_user_policy_attachment" "complete_user_ecr_access" {
  user       = aws_iam_user.petlove_complete_user.name
  policy_arn = aws_iam_policy.ecr_repo_access.arn
}

# Anexa a política de acesso ao S3 ao usuário completo
resource "aws_iam_user_policy_attachment" "complete_user_s3_access" {
  user       = aws_iam_user.petlove_complete_user.name
  policy_arn = aws_iam_policy.s3_bucket_access.arn
}

# Cria chaves de acesso para o usuário completo
resource "aws_iam_access_key" "complete_user_key" {
  user = aws_iam_user.petlove_complete_user.name
}
