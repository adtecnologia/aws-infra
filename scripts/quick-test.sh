#!/bin/bash

# Simplified test to validate the pipeline is working
echo "🔍 Quick Pipeline Test"
echo "===================="

# Test Terraform formatting
echo "📝 Testing Terraform format..."
if terraform fmt -check -recursive; then
    echo "✅ Terraform format: OK"
else
    echo "❌ Terraform format: FAILED"
    echo "Run 'terraform fmt -recursive' to fix"
fi

# Test validation
echo ""
echo "🔧 Testing Terraform validation..."
terraform init -backend=false > /dev/null 2>&1
if terraform validate > /dev/null 2>&1; then
    echo "✅ Terraform validation: OK"
else
    echo "❌ Terraform validation: FAILED"
fi

# Test cost analysis
echo ""
echo "💰 Testing cost analysis..."
echo "S3 Buckets found: $(find . -name "*.tf" -exec grep -l "aws_s3_bucket" {} \; | wc -l)"
echo "ECR Repos found: $(find . -name "*.tf" -exec grep -l "aws_ecr_repository" {} \; | wc -l)"

# Test workflow files
echo ""
echo "⚙️  Testing workflow files..."
workflows=(".github/workflows/terraform-ci.yml" ".github/workflows/docs.yml" ".github/workflows/drift-detection.yml")
for workflow in "${workflows[@]}"; do
    if [ -f "$workflow" ]; then
        echo "✅ $workflow exists"
    else
        echo "❌ $workflow missing"
    fi
done

echo ""
echo "🎉 Basic pipeline test complete!"
echo ""
echo "To test workflows on GitHub:"
echo "1. Commit and push your changes"
echo "2. Create a Pull Request"
echo "3. Check Actions tab to see workflows running"
