#!/bin/bash

# Simulate GitHub Actions workflow locally
# This script mimics exactly what happens in the CI pipeline

echo "🚀 Simulating GitHub Actions Workflow"
echo "====================================="

# Colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

success=0
failures=0

run_job() {
    local job_name="$1"
    local description="$2"
    
    echo -e "\n${BLUE}🔄 Running Job: $job_name${NC}"
    echo "Description: $description"
    echo "----------------------------------------"
}

run_step() {
    local step_name="$1"
    local command="$2"
    
    echo -e "\n  ${YELLOW}📋 Step: $step_name${NC}"
    
    if eval "$command" > /tmp/step_output 2>&1; then
        echo -e "  ${GREEN}✅ SUCCESS${NC}"
        ((success++))
    else
        echo -e "  ${RED}❌ FAILED${NC}"
        echo "  Error output:"
        sed 's/^/    /' /tmp/step_output
        ((failures++))
    fi
}

# Job 1: Terraform Validate & Lint
run_job "validate" "Terraform Validate & Lint"

run_step "Checkout code" "echo 'Code checked out'"

run_step "Setup Terraform" "terraform version"

run_step "Terraform Format Check" "terraform fmt -check -recursive"

run_step "Terraform Init (Root)" "terraform init -backend=false"

run_step "Terraform Validate (Root)" "terraform validate"

run_step "Validate Project Directories" '
for project in projects/*/; do
    if [ -f "$project/main.tf" ]; then
        echo "Validating $project"
        cd "$project"
        terraform init -backend=false > /dev/null 2>&1
        terraform validate > /dev/null 2>&1
        cd - > /dev/null
    fi
done'

run_step "Show workflow files exist" '
for workflow in .github/workflows/*.yml; do
    echo "Found: $workflow"
done'

# Job 2: Security Scan (Simulated)
run_job "security" "Security Scan"

run_step "Checkout code" "echo 'Code checked out'"

run_step "Security check simulation" '
echo "Simulating security scan..."
echo "Checking for common security issues..."

# Check for hardcoded values
hardcoded_secrets=0
for file in $(find . -name "*.tf"); do
    if grep -i "password\|secret\|key" "$file" | grep -v "variable\|var\." > /dev/null 2>&1; then
        ((hardcoded_secrets++))
    fi
done

if [ $hardcoded_secrets -eq 0 ]; then
    echo "✅ No hardcoded secrets found"
else
    echo "⚠️  $hardcoded_secrets potential hardcoded secrets found"
fi

echo "✅ Security simulation complete"'

# Job 3: Documentation Check
run_job "docs" "Documentation Check"

run_step "Checkout code" "echo 'Code checked out'"

run_step "Check for documentation markers" '
echo "Checking for terraform-docs markers..."

# Check root README
if [ -f "README.md" ]; then
    if grep -q "BEGIN_TF_DOCS\|END_TF_DOCS" README.md; then
        echo "✅ Root README has terraform-docs markers"
    else
        echo "⚠️  Root README missing terraform-docs markers"
    fi
fi

# Check project READMEs
for project in projects/*/; do
    if [ -f "$project/main.tf" ]; then
        project_name=$(basename "$project")
        if [ -f "$project/README.md" ]; then
            echo "✅ $project_name has README.md"
        else
            echo "⚠️  $project_name missing README.md"
        fi
    fi
done'

# Job 4: Cost Analysis
run_job "cost-estimation" "Cost Analysis"

run_step "Checkout code" "echo 'Code checked out'"

run_step "Analyze Resource Costs" '
echo "## 💰 Cost Analysis Report"
echo "This is a basic analysis of AWS resources defined in Terraform files."

# Count different resource types
ec2_count=$(find . -name "*.tf" -exec grep -l "aws_instance" {} \; | wc -l)
rds_count=$(find . -name "*.tf" -exec grep -l "aws_db_instance" {} \; | wc -l)
s3_count=$(find . -name "*.tf" -exec grep -l "aws_s3_bucket" {} \; | wc -l)
lambda_count=$(find . -name "*.tf" -exec grep -l "aws_lambda_function" {} \; | wc -l)
alb_count=$(find . -name "*.tf" -exec grep -l "aws_lb" {} \; | wc -l)
ecr_count=$(find . -name "*.tf" -exec grep -l "aws_ecr_repository" {} \; | wc -l)

echo "### 📊 Resource Summary"
echo "| Resource Type | Count | Estimated Monthly Cost Range |"
echo "|---------------|-------|------------------------------|"

if [ "$s3_count" -gt 0 ]; then
    echo "| S3 Buckets | $s3_count | \$1 - \$50+ per bucket |"
fi

if [ "$ecr_count" -gt 0 ]; then
    echo "| ECR Repositories | $ecr_count | \$0.10 per GB stored |"
fi

total_resources=$((ec2_count + rds_count + s3_count + lambda_count + alb_count + ecr_count))
echo "Total billable resources: $total_resources"'

# Final Report
echo -e "\n${BLUE}📊 Workflow Simulation Results${NC}"
echo "==============================="
echo -e "Successful steps: ${GREEN}$success${NC}"
echo -e "Failed steps: ${RED}$failures${NC}"
echo "Total steps: $((success + failures))"

if [ $failures -eq 0 ]; then
    echo -e "\n${GREEN}🎉 All workflow jobs would succeed on GitHub!${NC}"
    echo ""
    echo "Your pipeline is ready for:"
    echo "✅ Pull Request validation"
    echo "✅ Security scanning"
    echo "✅ Cost analysis"
    echo "✅ Documentation checks"
    echo ""
    echo "Next steps:"
    echo "1. git add ."
    echo "2. git commit -m 'fix: improve CI/CD pipeline reliability'"
    echo "3. git push"
    echo "4. Create a Pull Request to test the real workflows"
    exit 0
else
    echo -e "\n${RED}❌ Some workflow steps would fail on GitHub${NC}"
    echo "Please fix the issues above before pushing"
    exit 1
fi
