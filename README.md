# AWS Infrastructure Project

![AWS](https://skillicons.dev/icons?i=aws) ![Terraform](https://skillicons.dev/icons?i=terraform)

## Tecnologias Utilizadas

![AWS](https://skillicons.dev/icons?i=aws)
![Terraform](https://skillicons.dev/icons?i=terraform)

### Serviços AWS em uso:
- **Amazon ECR** - Elastic Container Registry
- **AWS IAM** - Identity and Access Management  
- **Amazon S3** - Simple Storage Service

## Inicialização do Projeto

### Pré-requisitos

Para inicializar este projeto de infraestrutura AWS, você precisa ter acesso à conta root da Active Directory da empresa, atualmente sob posse de **Daniel de Lima Mazali**.

### Passos para inicialização:

1. **Configuração da conta AWS**
   - Entre em contato com Daniel de Lima Mazali para obter acesso à conta root
   - Configure suas credenciais AWS localmente usando AWS CLI:
   ```bash
   aws configure
   ```

2. **Instalação do Terraform**
   - Instale o Terraform versão 6.12.0 ou superior
   - Verifique a instalação:
   ```bash
   terraform --version
   ```

3. **Clonagem e inicialização do repositório**
   ```bash
   git clone https://github.com/adtecnologia/aws-infra.git
   cd aws-infra
   terraform init
   ```

4. **Configuração das regiões**
   - O projeto está configurado para usar as seguintes regiões:
     - **Brasil**: `sa-east-1` (São Paulo)
     - **US**: `us-east-1` (Virginia do Norte)

## Estrutura do Projeto

```
aws-infra/
├── main.tf                    # Configuração principal do Terraform
├── variables.tf               # Variáveis globais do projeto
├── outputs.tf                 # Outputs globais
├── .terraform.lock.hcl        # Lock file do Terraform
├── .gitignore                 # Arquivos ignorados pelo Git
└── projects/                  # Diretório de projetos individuais
    ├── forplus/               # Projeto for+
    │   ├── main.tf           # Infraestrutura específica do for+
    │   ├── variables.tf      # Variáveis do projeto
    │   ├── outputs.tf        # Outputs do projeto
    │   └── modules/          # Módulos específicos
    │       ├── ECR/          # Configuração do Amazon ECR
    │       ├── IAM/          # Configuração do AWS IAM
    │       └── S3/           # Configuração do Amazon S3
    ├── luxtoon/              # Projeto Luxtoon
    │   ├── main.tf
    │   ├── variables.tf
    │   ├── outputs.tf
    │   └── modules/
    │       ├── ECR/
    │       ├── IAM/
    │       └── S3/
    ├── petlove/              # Projeto Petlove
    │   ├── main.tf
    │   ├── variables.tf
    │   ├── outputs.tf
    │   └── modules/
    │       ├── ECR/
    │       ├── IAM/
    │       └── S3/
    ├── plane/                # Projeto Plane
    │   ├── main.tf
    │   ├── variables.tf
    │   ├── outputs.tf
    │   └── modules/
    │       ├── IAM/
    │       └── S3/
    └── ugo-app/              # Projeto UGO App
        ├── main.tf
        ├── variables.tf
        ├── outputs.tf
        └── modules/
            ├── ECR/
            ├── IAM/
            └── S3/
```

### Descrição dos Módulos

#### Amazon ECR (Elastic Container Registry)
- **Função**: Repositório de contêineres Docker
- **Projetos**: forplus, luxtoon, petlove, ugo-app
- **Uso**: Armazenamento e gerenciamento de imagens Docker

#### AWS IAM (Identity and Access Management)
- **Função**: Gerenciamento de identidades e acessos
- **Projetos**: Todos os projetos
- **Uso**: Controle de permissões e políticas de segurança

#### Amazon S3 (Simple Storage Service)
- **Função**: Armazenamento de objetos
- **Projetos**: Todos os projetos
- **Uso**: Armazenamento de arquivos estáticos e backups

## Comandos Úteis

### Planejamento e Aplicação
```bash
# Planejar mudanças
terraform plan

# Aplicar mudanças
terraform apply

# Destruir infraestrutura (cuidado!)
terraform destroy
```

### Validação
```bash
# Validar configuração
terraform validate

# Formatar código
terraform fmt

# Verificar diferenças
terraform show
```

## Configuração Backend

O projeto utiliza um backend S3 para armazenar o estado do Terraform:
- **Bucket**: `adsolucoes-terraform`
- **Região**: `sa-east-1`
- **Criptografia**: Habilitada

## Contato

Para dúvidas sobre acesso à conta root ou configurações específicas:
- **Responsável**: Daniel de Lima Mazali
- **Empresa**: AD Tecnologia

---

## Documentação Técnica Terraform

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 6.12.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_forplus"></a> [forplus](#module\_forplus) | ./projects/forplus | n/a |
| <a name="module_luxtoon"></a> [luxtoon](#module\_luxtoon) | ./projects/luxtoon | n/a |
| <a name="module_petlove"></a> [petlove](#module\_petlove) | ./projects/petlove | n/a |
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