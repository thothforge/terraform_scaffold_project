# Technology Stack

## Core
- **IaC Tool**: Terraform >= 1.6 (pure HCL, no wrappers)
- **Cloud Provider**: AWS (~> 5.0)
- **State Backend**: S3 + DynamoDB locking
- **Linting**: TFLint with tflint-ruleset-aws v0.48.0 + tflint-ruleset-terraform v0.15.0
- **Pre-commit**: antonbabenko/pre-commit-terraform (fmt, validate, tflint, docs)

## Commands

```bash
# Initialize tflint plugins
tflint --init

# Lint all stacks recursively
tflint --recursive

# Work in a stack
cd stacks/<layer>/<component>
terraform init
terraform plan -var-file=../../../common/common.tfvars -var-file=../../../environments/<env>/<layer>.tfvars
terraform apply -var-file=../../../common/common.tfvars -var-file=../../../environments/<env>/<layer>.tfvars

# Pre-commit
pre-commit install
pre-commit run --all-files
```

## Conventions
- Each stack is self-contained (own providers.tf, versions.tf, backend.tf)
- State key path: `stacks/<layer>/<component>/terraform.tfstate`
- Variables shared via `-var-file` flags (no symlinks or inheritance)
- Terraform fmt enforced via pre-commit
