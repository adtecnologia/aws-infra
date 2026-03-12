# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is an **AWS Infrastructure-as-Code project** built with **Terraform** that manages cloud infrastructure for multiple products/projects of "AD Solucoes" (a Brazilian technology company).

- **Terraform**: >= 1.5.0
- **AWS Provider**: 6.14.0
- **Regions**: sa-east-1 (Brazil), us-east-1 (US - for CloudFront/ACM)

## Common Commands

```bash
# Run all checks (format + validate + lint)
make check

# Format all Terraform files
make fmt

# Check formatting without changes
make fmt-check

# Validate Terraform syntax
make validate

# Run TFLint static analysis
make lint

# Run terraform plan on all projects (dry-run)
make test

# Clean temporary files
make clean

# Install tools (terraform, tflint)
make install-tools

# Show all available commands
make help
```

## Architecture

### Directory Structure

```
projects/
├── ugo-app/          # Full infrastructure: S3, ECR, IAM, CloudFront
├── haras/            # Full infrastructure: S3, ECR, IAM, CloudFront
├── luxtoon/          # S3, ECR, IAM
├── petlove/          # S3, ECR, IAM
├── forplus/          # S3, ECR, IAM
├── plane/            # S3, IAM
└── vmpay/            # ECR, IAM
```

### Module Types

Each project uses reusable modules:

| Module | Resources |
|--------|-----------|
| **S3** | Public/private buckets, website hosting configuration |
| **ECR** | Docker container registries with lifecycle policies |
| **IAM** | IAM users with programmatic access keys |
| **CloudFront** | CDN distributions with OAC, SSL certificates, geo-restrictions |

### Key Patterns

1. **S3 + CloudFront**: Uses Origin Access Control (OAC) to restrict bucket access to CloudFront only. Custom error responses (404/403 → index.html) for SPA routing.

2. **ECR Lifecycle**: Auto-removes untagged images after 1 day, keeps only 1 latest tagged image.

3. **IAM Users**: Per-project users with access keys and policy attachments for S3/ECR/CloudFront.

4. **Backend**: Terraform state stored in S3 bucket `adsolucoes-terraform` (sa-east-1) with DynamoDB locking.

## CI/CD

- **GitHub Actions**: `terraform-check.yml` runs on pushes/PRs (fmt check, validate, TFLint)
- **Auto-format**: `terraform-format.yml` auto-formats and commits after pushes
- **Pre-commit hook**: `.git/hooks/pre-commit` blocks commits with formatting/syntax issues
- **Dependabot**: Weekly Terraform and GitHub Actions dependency updates

## Requirements

- AWS CLI configured with profile "ad-solucoes"
- Terraform installed
- TFLint (optional, for linting)
