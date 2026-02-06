# Usuário IAM com acesso completo aos recursos vmpay
resource "aws_iam_user" "vmpay_complete_user" {
  name = "vmpay-complete-user"
  path = "/"

  tags = {
    Name        = "vmpay Complete User"
    Project     = "vmpay-app"
    Environment = "production"
  }

  lifecycle {
    prevent_destroy = true
  }
}

# Anexa a política de acesso ao ECR ao usuário completo
resource "aws_iam_user_policy_attachment" "complete_user_ecr_access" {
  user       = aws_iam_user.vmpay_complete_user.name
  policy_arn = aws_iam_policy.ecr_policy.arn
}

# Cria chaves de acesso para o usuário completo
resource "aws_iam_access_key" "complete_user_key" {
  user = aws_iam_user.vmpay_complete_user.name
  lifecycle {
    prevent_destroy = true
  }
}
