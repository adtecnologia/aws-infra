# AWS Infraestrutura - Guia de Inicialização

<p align="left">
  <img src="https://skillicons.dev/icons?i=aws,terraform,docker,kubernetes" alt="AWS, Terraform, Docker & Kubernetes" height="48"/>
  <br>
  <img src="https://skillicons.dev/icons?i=dynamodb,lambda,cloudfront,redis" alt="DynamoDB, Lambda, CloudFront & Redis" height="48"/>
</p>

## Inicialização do Projeto

Para iniciar o projeto de infraestrutura AWS, é necessário utilizar a **conta root da AD**, atualmente sob posse de **Daniel de Lima Mazali**. Certifique-se de ter as credenciais apropriadas antes de executar qualquer comando.

> **Atenção:** O uso da conta root deve ser feito com cautela e apenas para operações essenciais.

## Estrutura de Pastas

A estrutura do projeto segue o padrão abaixo:

```
aws-infra/
├── README.md
├── modules/           # Módulos reutilizáveis do Terraform
├── environments/      # Configurações por ambiente (dev, prod, etc)
│   ├── dev/
│   └── prod/
├── scripts/           # Scripts auxiliares (bash, python, etc)
└── main.tf            # Arquivo principal do Terraform
```

- **modules/**: Contém módulos customizados para reutilização.
- **environments/**: Separa configurações por ambiente.
- **scripts/**: Scripts para automação e suporte.
- **main.tf**: Arquivo principal de configuração do Terraform.

## Requisitos

- Acesso à conta root da AD.
- <img src="https://skillicons.dev/icons?i=awscli" alt="AWS CLI" height="20"/> [AWS CLI](https://aws.amazon.com/cli/) configurado.
- <img src="https://skillicons.dev/icons?i=terraform" alt="Terraform" height="20"/> [Terraform](https://www.terraform.io/downloads.html) instalado.

---
> Para dúvidas ou acesso, contate Daniel de Lima Mazali.
