.PHONY: help init validate format lint security docs clean install-tools

# Default target
help: ## Show this help message
	@echo "Available targets:"
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "  %-20s %s\n", $$1, $$2}' $(MAKEFILE_LIST)

init: ## Initialize Terraform in all directories
	@echo "Initializing Terraform..."
	terraform init -backend=false
	@for project in projects/*/; do \
		if [ -f "$$project/main.tf" ]; then \
			echo "Initializing $$project"; \
			cd "$$project" && terraform init -backend=false && cd - > /dev/null; \
		fi \
	done

validate: init ## Validate Terraform configuration
	@echo "Validating Terraform configuration..."
	terraform validate
	@for project in projects/*/; do \
		if [ -f "$$project/main.tf" ]; then \
			echo "Validating $$project"; \
			cd "$$project" && terraform validate && cd - > /dev/null; \
		fi \
	done

format: ## Format Terraform files
	@echo "Formatting Terraform files..."
	terraform fmt -recursive

format-check: ## Check Terraform formatting
	@echo "Checking Terraform formatting..."
	terraform fmt -check -recursive -diff

lint: ## Run TFLint
	@echo "Running TFLint..."
	tflint --init
	tflint
	@for project in projects/*/; do \
		if [ -f "$$project/main.tf" ]; then \
			echo "Linting $$project"; \
			cd "$$project" && tflint && cd - > /dev/null; \
		fi \
	done

security: ## Run security checks with Checkov
	@echo "Running security checks..."
	checkov -d . --framework terraform --quiet --compact

docs: ## Generate documentation
	@echo "Generating documentation..."
	terraform-docs markdown table --output-file README.md .

pre-commit-install: ## Install pre-commit hooks
	@echo "Installing pre-commit hooks..."
	pre-commit install

pre-commit-run: ## Run pre-commit on all files
	@echo "Running pre-commit on all files..."
	pre-commit run --all-files

install-tools: ## Install required tools
	@echo "Installing required tools..."
	@if ! command -v terraform >/dev/null 2>&1; then \
		echo "Please install Terraform: https://developer.hashicorp.com/terraform/downloads"; \
	fi
	@if ! command -v tflint >/dev/null 2>&1; then \
		echo "Installing TFLint..."; \
		curl -s https://raw.githubusercontent.com/terraform-linters/tflint/master/install_linux.sh | bash; \
	fi
	@if ! command -v checkov >/dev/null 2>&1; then \
		echo "Installing Checkov..."; \
		pip install checkov; \
	fi
	@if ! command -v terraform-docs >/dev/null 2>&1; then \
		echo "Installing terraform-docs..."; \
		go install github.com/terraform-docs/terraform-docs@latest; \
	fi
	@if ! command -v pre-commit >/dev/null 2>&1; then \
		echo "Installing pre-commit..."; \
		pip install pre-commit; \
	fi

clean: ## Clean temporary files
	@echo "Cleaning temporary files..."
	find . -name ".terraform" -type d -exec rm -rf {} + 2>/dev/null || true
	find . -name ".terraform.lock.hcl" -delete 2>/dev/null || true
	find . -name "terraform.tfstate*" -delete 2>/dev/null || true

ci: format-check validate lint security ## Run all CI checks locally

cost-analysis: ## Analyze potential costs of resources
	@echo "Analyzing potential AWS costs..."
	@echo "=== Resource Count Analysis ==="
	@echo "EC2 Instances: $$(grep -r 'resource \"aws_instance\"' . | wc -l)"
	@echo "RDS Instances: $$(grep -r 'resource \"aws_db_instance\"' . | wc -l)"
	@echo "S3 Buckets: $$(grep -r 'resource \"aws_s3_bucket\"' . | wc -l)"
	@echo "Lambda Functions: $$(grep -r 'resource \"aws_lambda_function\"' . | wc -l)"
	@echo "Load Balancers: $$(grep -r 'resource \"aws_lb\"' . | wc -l)"
	@echo "ECR Repositories: $$(grep -r 'resource \"aws_ecr_repository\"' . | wc -l)"
	@echo ""
	@echo "💡 For detailed cost estimates, use AWS Pricing Calculator or Infracost"

setup: install-tools pre-commit-install init ## Complete setup for development environment
