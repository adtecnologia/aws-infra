# Terraform Quality Checks Configuration

# Este arquivo documenta as configurações de qualidade para o projeto

## Workflows GitHub Actions

### terraform-check.yml
- Executa em: pushes para main/develop e PRs
- Verifica: formatação, validação, TFLint
- Status: ✅ Configurado

### terraform-format.yml  
- Executa em: pushes para main com arquivos .tf
- Ação: Auto-formatação e commit
- Status: ✅ Configurado

## TFLint Rules Ativas

- terraform_deprecated_interpolation
- terraform_deprecated_index
- terraform_unused_declarations
- terraform_comment_syntax
- terraform_documented_outputs
- terraform_documented_variables
- terraform_typed_variables
- terraform_module_pinned_source
- terraform_naming_convention (snake_case)
- terraform_standard_module_structure

## Pre-commit Hook

Localização: .git/hooks/pre-commit
Verifica:
- Formatação dos arquivos .tf staged
- Validação das configurações
- Executável: ✅

## Comandos Make Disponíveis

- make check: Roda todos os checks
- make fmt: Formata arquivos
- make validate: Valida configurações
- make lint: Executa TFLint
- make test: Terraform plan dry-run
- make clean: Remove arquivos temporários

## Instalação de Ferramentas

Para instalar o TFLint:
```bash
make install-tools
```

Ou manualmente:
```bash
curl -s https://raw.githubusercontent.com/terraform-linters/tflint/master/install_linux.sh | bash
```
