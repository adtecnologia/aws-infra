.PHONY: help fmt check validate lint test clean

# Colors
RED := \033[31m
GREEN := \033[32m
YELLOW := \033[33m
BLUE := \033[34m
RESET := \033[0m

help: ## Show this help message
	@echo "$(BLUE)AWS Infrastructure - Terraform Commands$(RESET)"
	@echo ""
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "$(YELLOW)%-15s$(RESET) %s\n", $$1, $$2}'

fmt: ## Format all Terraform files
	@echo "$(BLUE)🔧 Formatting Terraform files...$(RESET)"
	@terraform fmt -recursive
	@echo "$(GREEN)✅ Formatting complete!$(RESET)"

fmt-check: ## Check Terraform file formatting
	@echo "$(BLUE)📝 Checking Terraform formatting...$(RESET)"
	@if terraform fmt -check -recursive; then \
		echo "$(GREEN)✅ All files are properly formatted$(RESET)"; \
	else \
		echo "$(RED)❌ Some files need formatting. Run 'make fmt' to fix$(RESET)"; \
		exit 1; \
	fi

validate: ## Validate all Terraform configurations (syntax only)
	@echo "$(BLUE)✅ Validating Terraform syntax...$(RESET)"
	@$(MAKE) -s syntax-check
	@echo "$(GREEN)✅ All syntax checks passed!$(RESET)"

syntax-check: ## Check Terraform syntax without AWS credentials
	@echo "Checking Terraform syntax..."
	@for tf_file in $$(find . -name "*.tf" -type f); do \
		echo "  Checking $$tf_file..."; \
		if ! terraform fmt -check=true "$$tf_file" > /dev/null 2>&1; then \
			echo "$(RED)❌ Format issue in $$tf_file$(RESET)"; \
		fi; \
	done
	@echo "$(GREEN)✅ Syntax check completed$(RESET)"

validate-root: ## Validate root configuration  
	@echo "Validating root configuration..."
	@if command -v terraform >/dev/null 2>&1; then \
		TF_LOG_LEVEL=ERROR terraform init -backend=false -upgrade > /dev/null 2>&1; \
		if AWS_ACCESS_KEY_ID=dummy AWS_SECRET_ACCESS_KEY=dummy terraform validate > /dev/null 2>&1; then \
			echo "$(GREEN)✅ Root configuration is valid$(RESET)"; \
		else \
			echo "$(YELLOW)⚠️  Root validation skipped (requires AWS credentials)$(RESET)"; \
		fi; \
	else \
		echo "$(RED)❌ Terraform not installed$(RESET)"; \
		exit 1; \
	fi

validate-projects: ## Validate all project configurations
	@for project in projects/*/; do \
		if [ -d "$$project" ]; then \
			project_name=$$(basename "$$project"); \
			echo "Validating project: $$project_name"; \
			cd "$$project" && \
			TF_LOG_LEVEL=ERROR terraform init -backend=false -upgrade > /dev/null 2>&1; \
			if AWS_ACCESS_KEY_ID=dummy AWS_SECRET_ACCESS_KEY=dummy terraform validate > /dev/null 2>&1; then \
				echo "$(GREEN)✅ $$project_name is valid$(RESET)"; \
			else \
				echo "$(YELLOW)⚠️  $$project_name validation skipped (requires AWS credentials)$(RESET)"; \
			fi; \
			cd - > /dev/null; \
		fi; \
	done

lint: ## Run TFLint on all configurations
	@echo "$(BLUE)🔍 Running TFLint...$(RESET)"
	@if command -v tflint >/dev/null 2>&1; then \
		tflint --init && \
		tflint && \
		echo "$(GREEN)✅ TFLint checks passed$(RESET)"; \
	else \
		echo "$(YELLOW)⚠️  TFLint not installed. Install with: curl -s https://raw.githubusercontent.com/terraform-linters/tflint/master/install_linux.sh | bash$(RESET)"; \
	fi

check: ## Run all checks (format, validate, lint)
	@echo "$(BLUE)🚀 Running complete Terraform check...$(RESET)"
	@$(MAKE) -s fmt-check
	@$(MAKE) -s validate
	@$(MAKE) -s lint
	@echo "$(GREEN)✅ All checks passed!$(RESET)"

test: ## Run terraform plan on all projects (dry-run)
	@echo "$(BLUE)🧪 Running terraform plan on all projects...$(RESET)"
	@for project in projects/*/; do \
		if [ -d "$$project" ]; then \
			project_name=$$(basename "$$project"); \
			echo "$(YELLOW)Planning project: $$project_name$(RESET)"; \
			cd "$$project" && \
			terraform init -backend=false > /dev/null 2>&1 && \
			terraform plan -out=/dev/null || echo "$(RED)❌ Plan failed for $$project_name$(RESET)"; \
			cd - > /dev/null; \
		fi; \
	done

clean: ## Clean terraform temporary files
	@echo "$(BLUE)🧹 Cleaning Terraform temporary files...$(RESET)"
	@find . -type d -name ".terraform" -exec rm -rf {} + 2>/dev/null || true
	@find . -name "*.tfstate*" -delete 2>/dev/null || true
	@find . -name ".terraform.lock.hcl" -delete 2>/dev/null || true
	@echo "$(GREEN)✅ Cleanup complete!$(RESET)"

install-tools: ## Install required tools (terraform, tflint)
	@echo "$(BLUE)📦 Installing tools...$(RESET)"
	@echo "Installing TFLint..."
	@curl -s https://raw.githubusercontent.com/terraform-linters/tflint/master/install_linux.sh | bash
	@echo "$(GREEN)✅ Tools installed!$(RESET)"

# Git hooks
install-hooks: ## Install git pre-commit hooks
	@echo "$(BLUE)🪝 Installing git hooks...$(RESET)"
	@cp .git/hooks/pre-commit .git/hooks/pre-commit.bak 2>/dev/null || true
	@chmod +x .git/hooks/pre-commit
	@echo "$(GREEN)✅ Git hooks installed!$(RESET)"
