# UGO App

Infraestrutura AWS para o UGO App.

## Recursos

- ECR Repository para imagens Docker
- S3 Buckets (desenvolvimento e privado)
- IAM roles e policies

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_ECR"></a> [ECR](#module\_ECR) | ./modules/ECR | n/a |
| <a name="module_IAM"></a> [IAM](#module\_IAM) | ./modules/IAM | n/a |
| <a name="module_S3"></a> [S3](#module\_S3) | ./modules/S3 | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_region"></a> [region](#input\_region) | Mapa de regiões AWS disponíveis (herdado do módulo raiz) | `map(string)` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
