#!/bin/bash

# Setup script for local development environment
# This script installs and configures tools for Terraform development

set -e

echo "🚀 Setting up Terraform development environment..."

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to print colored output
print_status() {
    echo -e "${GREEN}✓${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}⚠${NC} $1"
}

print_error() {
    echo -e "${RED}✗${NC} $1"
}

# Check for required tools and install if missing
echo "📋 Checking required tools..."

# Check Terraform
if command_exists terraform; then
    print_status "Terraform is installed ($(terraform version | head -n1))"
else
    print_error "Terraform is not installed"
    echo "Please install Terraform from: https://developer.hashicorp.com/terraform/downloads"
    exit 1
fi

# Check TFLint
if command_exists tflint; then
    print_status "TFLint is installed ($(tflint --version))"
else
    print_warning "TFLint is not installed. Installing..."
    curl -s https://raw.githubusercontent.com/terraform-linters/tflint/master/install_linux.sh | bash
    print_status "TFLint installed"
fi

# Check Python
if command_exists python3; then
    print_status "Python 3 is installed ($(python3 --version))"
else
    print_error "Python 3 is not installed"
    echo "Please install Python 3"
    exit 1
fi

# Check pip
if command_exists pip3; then
    print_status "pip3 is installed"
else
    print_error "pip3 is not installed"
    echo "Please install pip3"
    exit 1
fi

# Install Checkov
if command_exists checkov; then
    print_status "Checkov is installed ($(checkov --version))"
else
    print_warning "Checkov is not installed. Installing..."
    pip3 install checkov
    print_status "Checkov installed"
fi

# Install pre-commit
if command_exists pre-commit; then
    print_status "pre-commit is installed ($(pre-commit --version))"
else
    print_warning "pre-commit is not installed. Installing..."
    pip3 install pre-commit
    print_status "pre-commit installed"
fi

# Check terraform-docs
if command_exists terraform-docs; then
    print_status "terraform-docs is installed ($(terraform-docs version))"
else
    print_warning "terraform-docs is not installed"
    echo "Please install terraform-docs:"
    echo "  - macOS: brew install terraform-docs"
    echo "  - Linux: download from https://github.com/terraform-docs/terraform-docs/releases"
    echo "  - Go: go install github.com/terraform-docs/terraform-docs@latest"
fi

# Setup pre-commit hooks
echo ""
echo "🔧 Setting up pre-commit hooks..."
if [ -f ".pre-commit-config.yaml" ]; then
    pre-commit install
    print_status "Pre-commit hooks installed"
else
    print_warning "No .pre-commit-config.yaml found, skipping pre-commit setup"
fi

# Initialize TFLint
echo ""
echo "🔧 Initializing TFLint..."
if [ -f ".tflint.hcl" ]; then
    tflint --init
    print_status "TFLint initialized"
else
    print_warning "No .tflint.hcl found, skipping TFLint initialization"
fi

# Validate Terraform configurations
echo ""
echo "🔍 Validating Terraform configurations..."

# Root configuration
if [ -f "main.tf" ]; then
    echo "Validating root configuration..."
    terraform init -backend=false
    terraform validate
    print_status "Root configuration is valid"
fi

# Project configurations
for project in projects/*/; do
    if [ -f "$project/main.tf" ]; then
        echo "Validating $project..."
        cd "$project"
        terraform init -backend=false
        terraform validate
        cd - > /dev/null
        print_status "$project is valid"
    fi
done

# Format check
echo ""
echo "🎨 Checking Terraform formatting..."
if terraform fmt -check -recursive; then
    print_status "All Terraform files are properly formatted"
else
    print_warning "Some Terraform files need formatting"
    echo "Run 'make format' to fix formatting issues"
fi

echo ""
echo "🎉 Setup complete!"
echo ""
echo "Available commands:"
echo "  make help          - Show available commands"
echo "  make validate      - Validate all Terraform configurations"
echo "  make format        - Format all Terraform files"
echo "  make lint          - Run TFLint on all configurations"
echo "  make security      - Run security checks with Checkov"
echo "  make docs          - Generate documentation"
echo "  make cost-analysis - Analyze potential AWS costs"
echo "  make ci            - Run all CI checks locally"
echo "  make pre-commit-run - Run pre-commit on all files"
echo ""
echo "Happy coding! 🚀"
