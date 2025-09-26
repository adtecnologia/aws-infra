# AWS Infraestrutura - Guia de Inicialização

<p align="left">
  <img src="https://skillicons.dev/icons?i=aws,terraform" alt="AWS, Terraform Docker" height="48"/>
  <br>
  <img src="https://skillicons.dev/icons?i=docker,debian" alt="DynamoDB, Lambda, CloudFront & Redis" height="48"/>
</p>

## 🚀 Quick Start

### Terraform Checks e Linting

Este projeto conta com verificações automáticas de Terraform que rodam a cada commit:

- **🔧 Formatação**: `terraform fmt -check -recursive`  
- **✅ Validação**: `terraform validate` em todas as configurações
- **🔍 Análise Estática**: TFLint com regras AWS
- **🤖 CI/CD**: GitHub Actions para verificações automáticas

### Comandos Rápidos

```bash
# Rodar todos os checks localmente
make check

# Formatar todos os arquivos
make fmt

# Validar configurações
make validate

# Executar linter
make lint
```

## Inicialização do Projeto

Para iniciar o projeto de infraestrutura AWS, é necessário utilizar a **conta root da AD**, atualmente sob posse de **Daniel de Lima Mazali**. Certifique-se de ter as credenciais apropriadas antes de executar qualquer comando.

> **Atenção:** O uso da conta root deve ser feito com cautela e apenas para operações essenciais.

## Estrutura de Pastas

A estrutura do projeto segue o padrão abaixo:

``` bash
aws-infra
├── main.tf
├── outputs.tf
├── projects
│   ├── forplus
│   │   ├── main.tf
│   │   ├── modules/
│   │   ├── outputs.tf
│   │   └── variables.tf
│   ├── luxtoon
│   │   ├── main.tf
│   │   ├── modules/
│   │   ├── outputs.tf
│   │   └── variables.tf
│   ├── petlove
│   │   ├── main.tf
│   │   ├── modules/
│   │   ├── outputs.tf
│   │   └── variables.tf
│   ├── plane
│   │   ├── main.tf
│   │   ├── modules/
│   │   ├── outputs.tf
│   │   └── variables.tf
│   └── ugo-app
│       ├── main.tf
│       ├── modules
│       │   ├── ECR
│       │   │   ├── outputs.tf
│       │   │   └── ugo-image-repo.tf      # Repositório Docker com políticas de lifecycle
│       │   ├── IAM
│       │   │   ├── acesso-ECR.tf          # Políticas de acesso ao ECR
│       │   │   ├── acesso-S3.tf           # Políticas de acesso ao S3
│       │   │   ├── outputs.tf
│       │   │   └── usuario-completo.tf    # Usuário IAM com acesso total
│       │   └── S3
│       │       ├── ugo-dev.tf             # Bucket privado para desenvolvimento
│       │       ├── ugo-private.tf         # Bucket privado para produção
│       │       └── variables.tf
│       ├── outputs.tf
│       └── variables.tf
├── README.md
└── variables.tf
```

- **projects/**: Contém módulos de projetos.
- **modules/**: Secregação de recursos.
- **main.tf**: Arquivo principal de configuração do Terraform.

## Requisitos

- Acesso à conta root da AD.
- AWS CLI configurado.
- Terraform instalado.
- (Opcional) TFLint para análise estática adicional

## 🔧 Ferramentas e Workflows

### GitHub Actions

O projeto possui workflows automatizados:

- **terraform-check.yml**: Roda em pushes e PRs
  - ✅ Verifica formatação (`terraform fmt -check`)
  - ✅ Valida sintaxe (`terraform validate`)  
  - ✅ Executa TFLint para análise estática
  - ✅ Testa todos os projetos individualmente
  - 💬 Comenta resultados em PRs

- **terraform-format.yml**: Auto-formatação
  - 🤖 Formata arquivos automaticamente após pushes
  - 📝 Faz commit das correções de formatação

### Pre-commit Hook

Um hook local está disponível em `.git/hooks/pre-commit` que:
- ✅ Verifica formatação antes do commit
- ✅ Valida configurações Terraform
- ❌ Bloqueia commits com problemas

### Makefile Commands

```bash
make help          # Mostra todos os comandos disponíveis
make fmt           # Formata todos os arquivos .tf
make fmt-check     # Verifica formatação sem alterar
make validate      # Valida todas as configurações
make lint          # Executa TFLint 
make check         # Executa todos os checks
make test          # Roda terraform plan (dry-run)
make clean         # Remove arquivos temporários
make install-tools # Instala ferramentas necessárias
```

### TFLint Configuration

O arquivo `.tflint.hcl` configura:
- Regras recomendadas do Terraform
- Plugin AWS com validações específicas
- Convenções de nomenclatura
- Validações de estrutura de módulos

---
> Para dúvidas ou acesso, contate Daniel de Lima Mazali.
