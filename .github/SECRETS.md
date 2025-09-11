# GitHub Secrets Configuration

Este documento descreve os secrets necessários para configurar os workflows do GitHub Actions neste repositório.

## Secrets Obrigatórios

### AWS Credentials

Para workflows que interagem com a AWS (drift detection, deploy, etc.):

- `AWS_ACCESS_KEY_ID` - Access Key ID da AWS
- `AWS_SECRET_ACCESS_KEY` - Secret Access Key da AWS

## Variables de Repositório

### AWS Configuration

- `AWS_DEFAULT_REGION` - Região padrão da AWS (ex: `us-east-1`, `sa-east-1`)

## Como configurar

### Secrets

1. Vá para Settings > Secrets and variables > Actions
2. Clique em "New repository secret"
3. Adicione cada secret com o nome exato listado acima

### Variables

1. Vá para Settings > Secrets and variables > Actions
2. Clique na aba "Variables"
3. Clique em "New repository variable"
4. Adicione cada variável com o nome exato listado acima

## Segurança

- **Nunca** commite secrets no código
- Use secrets específicos para CI/CD com permissões mínimas
- Considere usar OIDC (OpenID Connect) para autenticação sem secrets
- Rotacione secrets regularmente

## OIDC Alternative (Recomendado)

Para maior segurança, considere configurar OIDC em vez de usar access keys:

1. Configure um OIDC provider na AWS
2. Crie um role IAM com as permissões necessárias
3. Configure o trust policy para permitir acesso do GitHub Actions
4. Use `aws-actions/configure-aws-credentials` com `role-to-assume`

Exemplo:
```yaml
- name: Configure AWS credentials
  uses: aws-actions/configure-aws-credentials@v4
  with:
    role-to-assume: arn:aws:iam::123456789012:role/github-actions-role
    aws-region: us-east-1
```
