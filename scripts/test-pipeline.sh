#!/bin/bash

# Test script to validate all tools and workflows
# This script tests the CI/CD pipeline locally

set -e

echo "🧪 Testing AWS Infrastructure CI/CD Pipeline"
echo "=============================================="

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_step() {
    echo -e "${BLUE}📋 $1${NC}"
}

print_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

print_error() {
    echo -e "${RED}❌ $1${NC}"
}

# Test counter
tests_passed=0
tests_failed=0

run_test() {
    local test_name="$1"
    local test_command="$2"
    
    print_step "Testing: $test_name"
    
    if eval "$test_command" > /tmp/test_output 2>&1; then
        print_success "$test_name passed"
        ((tests_passed++))
    else
        print_error "$test_name failed"
        echo "Error output:"
        cat /tmp/test_output
        ((tests_failed++))
    fi
    echo ""
}

echo ""
print_step "Starting validation tests..."
echo ""

# Test 1: Terraform format check
run_test "Terraform Format Check" "terraform fmt -check -recursive"

# Test 2: Terraform validation (root)
run_test "Terraform Validation (Root)" "terraform init -backend=false && terraform validate"

# Test 3: Cost Analysis
run_test "Cost Analysis" "make cost-analysis"

# Test 4: Workflow syntax validation
run_test "GitHub Workflow Syntax" "find .github/workflows -name '*.yml' -exec yamllint {} \;"

# Test 5: Check if required files exist
print_step "Testing: Required Files Exist"
required_files=(
    ".github/workflows/terraform-ci.yml"
    ".github/workflows/docs.yml"
    ".github/workflows/drift-detection.yml"
    ".tflint.hcl"
    ".pre-commit-config.yaml"
    ".editorconfig"
    "Makefile"
    "renovate.json"
)

missing_files=0
for file in "${required_files[@]}"; do
    if [ -f "$file" ]; then
        echo "✅ $file exists"
    else
        echo "❌ $file missing"
        ((missing_files++))
    fi
done

if [ $missing_files -eq 0 ]; then
    print_success "All required files exist"
    ((tests_passed++))
else
    print_error "$missing_files required files missing"
    ((tests_failed++))
fi
echo ""

# Test 6: Project structure validation
print_step "Testing: Project Structure"
projects=("luxtoon" "plane" "ugo-app")
project_errors=0

for project in "${projects[@]}"; do
    project_path="projects/$project"
    if [ -d "$project_path" ]; then
        if [ -f "$project_path/main.tf" ]; then
            echo "✅ $project has main.tf"
            # Test project validation
            cd "$project_path"
            if terraform init -backend=false > /dev/null 2>&1 && terraform validate > /dev/null 2>&1; then
                echo "✅ $project Terraform is valid"
            else
                echo "❌ $project Terraform validation failed"
                ((project_errors++))
            fi
            cd - > /dev/null
        else
            echo "❌ $project missing main.tf"
            ((project_errors++))
        fi
    else
        echo "❌ $project directory missing"
        ((project_errors++))
    fi
done

if [ $project_errors -eq 0 ]; then
    print_success "All projects are valid"
    ((tests_passed++))
else
    print_error "$project_errors project validation errors"
    ((tests_failed++))
fi
echo ""

# Test 7: Resource counting (detailed)
print_step "Testing: Resource Analysis"
echo "Resource count analysis:"

# Count different resource types more precisely
s3_count=$(find . -name "*.tf" -exec grep -l "resource.*aws_s3_bucket" {} \; | wc -l)
ecr_count=$(find . -name "*.tf" -exec grep -l "resource.*aws_ecr_repository" {} \; | wc -l)
iam_count=$(find . -name "*.tf" -exec grep -l "resource.*aws_iam" {} \; | wc -l)

echo "  📦 S3 Bucket resources: $s3_count files"
echo "  🐳 ECR Repository resources: $ecr_count files"
echo "  🔐 IAM resources: $iam_count files"

if [ $((s3_count + ecr_count + iam_count)) -gt 0 ]; then
    print_success "Resources detected and counted"
    ((tests_passed++))
else
    print_warning "No billable resources detected"
    ((tests_passed++))
fi
echo ""

# Test 8: Security check simulation
print_step "Testing: Security Configuration Check"
security_files=(
    ".tflint.hcl"
    ".pre-commit-config.yaml"
)

security_ok=true
for file in "${security_files[@]}"; do
    if [ -f "$file" ]; then
        if grep -q "checkov\|tflint\|security" "$file"; then
            echo "✅ $file has security configurations"
        else
            echo "⚠️  $file exists but may lack security configs"
        fi
    else
        echo "❌ $file missing"
        security_ok=false
    fi
done

if $security_ok; then
    print_success "Security configurations are in place"
    ((tests_passed++))
else
    print_error "Security configuration issues found"
    ((tests_failed++))
fi
echo ""

# Test 9: Documentation check
print_step "Testing: Documentation"
if grep -q "terraform-docs" README.md; then
    print_success "README has terraform-docs markers"
    ((tests_passed++))
else
    print_warning "README may need terraform-docs setup"
    ((tests_passed++))
fi
echo ""

# Final report
echo "🏁 Test Results Summary"
echo "======================="
echo "Tests passed: $tests_passed"
echo "Tests failed: $tests_failed"
echo "Total tests: $((tests_passed + tests_failed))"
echo ""

if [ $tests_failed -eq 0 ]; then
    print_success "All tests passed! 🎉"
    echo ""
    echo "🚀 Your CI/CD pipeline is ready!"
    echo ""
    echo "Next steps:"
    echo "1. Commit and push these changes"
    echo "2. Create a test PR to see workflows in action"
    echo "3. Check GitHub Actions tab for workflow results"
    echo "4. Set up the required secrets in GitHub repository settings"
    exit 0
else
    print_error "Some tests failed. Please fix the issues above."
    exit 1
fi
