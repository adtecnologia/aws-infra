# AWS Infrastructure as Code

Este repositório contém a infraestrutura AWS da AD Tecnologia, gerenciada com Terraform.

## 🏗️ Estrutura do Projeto

```
aws-infra/
├── main.tf                 # Configuração raiz do Terraform
├── variables.tf           # Variáveis globais
├── outputs.tf             # Outputs globais
├── projects/              # Projetos específicos
│   ├── luxtoon/          # Infraestrutura do Luxtoon
│   ├── plane/            # Infraestrutura do Plane
│   └── ugo-app/          # Infraestrutura do UGO App
├── .github/
│   └── workflows/        # GitHub Actions workflows
└── scripts/              # Scripts de automação
```

## 🚀 Quick Start

### Configuração do Ambiente Local

1. Execute o script de setup:
```bash
./scripts/setup-dev.sh
```

2. Ou configure manualmente:
```bash
make setup
```

### Comandos Disponíveis

```bash
make help          # Mostra todos os comandos disponíveis
make validate      # Valida todas as configurações Terraform
make format        # Formata todos os arquivos Terraform
make lint          # Executa TFLint em todas as configurações
make security      # Executa verificações de segurança com Checkov
make docs          # Gera documentação automaticamente
make cost-analysis # Analisa custos potenciais dos recursos AWS
make ci            # Executa todas as verificações de CI localmente
```

## 🔧 Ferramentas e Workflows

### GitHub Actions

- **terraform-ci.yml**: Validação, linting, segurança e análise de custos
- **docs.yml**: Geração automática de documentação
- **drift-detection.yml**: Detecção automática de drift na infraestrutura

### Ferramentas de Qualidade

- **TFLint**: Linting de código Terraform
- **Checkov**: Análise de segurança e compliance
- **terraform-docs**: Geração automática de documentação
- **pre-commit**: Hooks para verificação antes do commit

### Análise de Custos

O projeto inclui análise básica de custos que conta recursos AWS e fornece estimativas gerais. Para análises detalhadas, use:

- [AWS Pricing Calculator](https://calculator.aws/)
- [Infracost](https://www.infracost.io/) (com API key)
- AWS Cost Explorer (após deployment)

## 📋 Pré-requisitos

- [Terraform](https://developer.hashicorp.com/terraform/downloads) >= 1.9.0
- [TFLint](https://github.com/terraform-linters/tflint)
- [Python 3](https://www.python.org/) com pip
- [pre-commit](https://pre-commit.com/)

## 🔐 Configuração de Secrets

Consulte [.github/SECRETS.md](.github/SECRETS.md) para configurar os secrets necessários no GitHub.

## 🏃‍♂️ Workflow de Desenvolvimento

1. Crie uma branch para sua feature/fix
2. Faça suas alterações no Terraform
3. Execute os testes localmente: `make ci`
4. Commit e push das alterações
5. Abra um Pull Request
6. Os workflows automáticos irão validar suas alterações
7. Após aprovação, merge para main

## 📖 Projetos

### Luxtoon
Infraestrutura para o projeto Luxtoon, incluindo:
- ECR repository para imagens Docker
- S3 bucket privado
- IAM roles e policies

### Plane
Infraestrutura para o projeto Plane, incluindo:
- S3 bucket privado
- IAM roles e policies

### UGO App
Infraestrutura para o UGO App, incluindo:
- ECR repository para imagens Docker
- S3 buckets (desenvolvimento e privado)
- IAM roles e policies

## 🤝 Contribuindo

1. Siga as convenções de nomenclatura do Terraform
2. Documente todas as variáveis e outputs
3. Execute `make ci` antes de commitar
4. Mantenha os módulos pequenos e reutilizáveis
5. Use tags adequadas nos recursos AWS

## 📞 Suporte

Para dúvidas ou problemas, abra uma issue neste repositório.

---

## 📄 Documentação Terraform

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 6.12 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_luxtoon"></a> [luxtoon](#module\_luxtoon) | ./projects/luxtoon | n/a |
| <a name="module_plane"></a> [plane](#module\_plane) | ./projects/plane | n/a |
| <a name="module_ugo-app"></a> [ugo-app](#module\_ugo-app) | ./projects/ugo-app | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_region"></a> [region](#input\_region) | Mapa de regiões AWS disponíveis | `map(string)` | <pre>{<br>  "brasil": "sa-east-1",<br>  "us": "us-east-1"<br>}</pre> | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->