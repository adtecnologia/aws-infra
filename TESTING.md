# 🧪 Como Testar se o Pipeline Funciona

Este guia explica como validar se todos os workflows e ferramentas estão funcionando corretamente.

## 🚀 Testes Locais (Antes de Commitar)

### 1. Teste Rápido
```bash
./scripts/quick-test.sh
```

### 2. Teste Completo com Make
```bash
# Teste individual de cada ferramenta
make format-check    # Verifica formatação
make validate       # Valida Terraform
make cost-analysis  # Analisa custos
make help          # Lista todos os comandos

# Teste completo (simula CI)
make ci
```

### 3. Teste de Setup Local
```bash
./scripts/setup-dev.sh
```

## 🔍 Testes no GitHub (Workflows)

### 1. Teste do Workflow Principal
**Como testar:** Criar um Pull Request

**O que acontece:**
- ✅ Formatação do Terraform
- ✅ Validação do Terraform  
- ✅ Linting com TFLint
- ✅ Análise de segurança com Checkov
- ✅ Análise de custos (comentário no PR)
- ✅ Verificação de documentação

**Como ver os resultados:**
1. Vá para a aba "Actions" no GitHub
2. Clique no workflow "Terraform CI" 
3. Veja os logs detalhados de cada step

### 2. Teste do Drift Detection
**Como testar:** O workflow roda automaticamente todo dia às 9h UTC

**Teste manual:**
1. Vá para Actions → Terraform Drift Detection
2. Clique em "Run workflow"
3. Execute manualmente

**O que acontece:**
- 🔍 Compara estado atual vs configuração
- 📋 Cria issue se houver drift
- ✅ Fecha issue se não houver drift

### 3. Teste de Documentação
**Como testar:** Fazer alterações em arquivos `.tf`

**O que acontece:**
- 📝 Gera documentação automaticamente
- 💬 Comenta no PR se docs precisam atualização
- 🔄 Atualiza README após merge

## 📊 Resultados Esperados

### ✅ Sucesso nos Testes
```
🎉 All tests passed!

Tests passed: 9
Tests failed: 0
Total tests: 9
```

### 💰 Análise de Custos (Exemplo)
```
=== Resource Count Analysis ===
S3 Buckets found: 4
ECR Repos found: 2

| Resource Type | Count | Estimated Monthly Cost Range |
|---------------|-------|------------------------------|
| S3 Buckets | 4 | $1 - $50+ per bucket |
| ECR Repositories | 2 | $0.10 per GB stored |
```

### 📋 Comentário no PR (Exemplo)
```
## 💰 Cost Analysis Report

This is a basic analysis of AWS resources defined in Terraform files.

### 📊 Resource Summary
| Resource Type | Count | Estimated Monthly Cost Range |
|---------------|-------|------------------------------|
| S3 Buckets | 4 | $1 - $50+ per bucket |
| ECR Repositories | 2 | $0.10 per GB stored |

### 💡 Cost Optimization Tips
- Use appropriate instance sizes for your workload
- Consider using Spot instances for non-critical workloads
- Implement S3 lifecycle policies for storage optimization
```

## 🐛 Troubleshooting

### Problema: Terraform validate falha
**Solução:**
```bash
# Inicializar Terraform
terraform init -backend=false

# Verificar erros específicos
terraform validate
```

### Problema: Workflow falha no GitHub
**Verificar:**
1. Secrets configurados (AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY)
2. Variables configuradas (AWS_DEFAULT_REGION)
3. Logs detalhados na aba Actions

### Problema: TFLint não encontrado
**Solução:**
```bash
# Instalar TFLint
curl -s https://raw.githubusercontent.com/terraform-linters/tflint/master/install_linux.sh | bash

# Ou usar o setup
./scripts/setup-dev.sh
```

## 🎯 Cenários de Teste

### 1. Teste de PR Normal
1. Criar branch: `git checkout -b test/pipeline`
2. Fazer pequena alteração em um `.tf`
3. Commit e push
4. Criar PR
5. Verificar workflows na aba Actions

### 2. Teste de Erro de Formatação
1. Desformatar um arquivo `.tf` propositalmente
2. Fazer PR
3. Verificar se workflow detecta o erro
4. Ver comentário automático no PR

### 3. Teste de Segurança
1. Adicionar resource com configuração insegura
2. Fazer PR  
3. Verificar se Checkov detecta problemas

### 4. Teste de Drift Detection
1. Fazer deploy de recursos reais (opcional)
2. Modificar recursos manualmente na AWS
3. Aguardar ou executar workflow manualmente
4. Verificar se cria issue automaticamente

## 📈 Métricas de Sucesso

- ✅ **100% dos workflows executam sem erro**
- ✅ **Comentários automáticos aparecem nos PRs**
- ✅ **Documentação atualizada automaticamente**
- ✅ **Issues de drift criadas quando necessário**
- ✅ **Análise de custos funciona sem API keys**

## 🔗 Links Úteis

- [GitHub Actions Tab](../../actions)
- [AWS Pricing Calculator](https://calculator.aws/)
- [Terraform Documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
- [TFLint Rules](https://github.com/terraform-linters/tflint-ruleset-aws/blob/master/docs/rules/README.md)
