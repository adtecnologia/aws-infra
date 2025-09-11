#!/bin/bash

# Script to generate documentation using terraform-docs
# This simulates what the GitHub Actions workflow does

echo "📝 Generating Terraform Documentation"
echo "====================================="

# Check if terraform-docs is installed
if ! command -v terraform-docs >/dev/null 2>&1; then
    echo "⚠️  terraform-docs not found locally"
    echo "To install:"
    echo "  - macOS: brew install terraform-docs"
    echo "  - Linux: go install github.com/terraform-docs/terraform-docs@latest"
    echo "  - Or download from: https://github.com/terraform-docs/terraform-docs/releases"
    echo ""
    echo "🔄 Simulating documentation generation..."
    
    # Simulate what terraform-docs would generate
    echo "## Requirements" > temp_docs.md
    echo "" >> temp_docs.md
    echo "No requirements." >> temp_docs.md
    echo "" >> temp_docs.md
    echo "## Providers" >> temp_docs.md
    echo "" >> temp_docs.md
    echo "| Name | Version |" >> temp_docs.md
    echo "|------|---------|" >> temp_docs.md
    echo "| <a name=\"provider_aws\"></a> [aws](#provider\_aws) | n/a |" >> temp_docs.md
    echo "" >> temp_docs.md
    echo "## Resources" >> temp_docs.md
    echo "" >> temp_docs.md
    
    # Count resources
    s3_count=$(find . -name "*.tf" -exec grep -c "resource.*aws_s3_bucket" {} + 2>/dev/null | awk '{sum+=$1} END {print sum+0}')
    ecr_count=$(find . -name "*.tf" -exec grep -c "resource.*aws_ecr_repository" {} + 2>/dev/null | awk '{sum+=$1} END {print sum+0}')
    iam_count=$(find . -name "*.tf" -exec grep -c "resource.*aws_iam" {} + 2>/dev/null | awk '{sum+=$1} END {print sum+0}')
    
    echo "| Name | Type |" >> temp_docs.md
    echo "|------|------|" >> temp_docs.md
    
    if [ $s3_count -gt 0 ]; then
        echo "| aws_s3_bucket | resource |" >> temp_docs.md
    fi
    if [ $ecr_count -gt 0 ]; then
        echo "| aws_ecr_repository | resource |" >> temp_docs.md
    fi
    if [ $iam_count -gt 0 ]; then
        echo "| aws_iam_* | resource |" >> temp_docs.md
    fi
    
    echo ""
    echo "📊 Documentation Preview:"
    cat temp_docs.md
    rm temp_docs.md
    
    echo ""
    echo "✅ Simulation complete - this shows what terraform-docs would generate"
    exit 0
fi

echo "✅ terraform-docs found: $(terraform-docs version)"
echo ""

# Generate docs for root
echo "📝 Generating documentation for root..."
if [ -f "main.tf" ]; then
    terraform-docs markdown table --output-file README.md .
    echo "✅ Root documentation updated"
else
    echo "⚠️  No main.tf found in root"
fi

# Generate docs for projects
echo ""
echo "📝 Generating documentation for projects..."
for project in projects/*/; do
    if [ -f "$project/main.tf" ]; then
        echo "  → $project"
        cd "$project"
        
        # Create README if it doesn't exist
        if [ ! -f "README.md" ]; then
            echo "# $(basename $(pwd))" > README.md
            echo "" >> README.md
            echo "<!-- BEGIN_TF_DOCS -->" >> README.md
            echo "<!-- END_TF_DOCS -->" >> README.md
        fi
        
        terraform-docs markdown table --output-file README.md .
        cd - > /dev/null
        echo "    ✅ Documentation generated"
    else
        echo "  ⚠️  $project: No main.tf found"
    fi
done

echo ""
echo "🎉 Documentation generation complete!"
echo ""
echo "Files updated:"
echo "  - README.md (root)"
for project in projects/*/; do
    if [ -f "$project/README.md" ]; then
        echo "  - $project/README.md"
    fi
done
