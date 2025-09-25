# AWS Infraestrutura - Guia de Inicialização

<p align="left">
  <img src="https://skillicons.dev/icons?i=aws,terraform" alt="AWS, Terraform Docker" height="48"/>
  <br>
  <img src="https://skillicons.dev/icons?i=docker,debian" alt="DynamoDB, Lambda, CloudFront & Redis" height="48"/>
</p>

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
- <img src="https://skillicons.dev/icons?i=aws" alt="AWS CLI" height="20"/> [AWS CLI](https://aws.amazon.com/cli/) configurado.
- <img src="https://skillicons.dev/icons?i=terraform" alt="Terraform" height="20"/> [Terraform](https://www.terraform.io/downloads.html) instalado.

---
> Para dúvidas ou acesso, contate Daniel de Lima Mazali.
