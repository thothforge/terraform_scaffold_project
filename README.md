# Terraform Scaffold

Enterprise-grade AWS infrastructure scaffold using pure Terraform with a layered architecture based on Domain-Driven Design (DDD) principles.

## Architecture

The project implements four infrastructure layers with strict dependency ordering:

```
Foundation → Platform → Application → Observability
```

### Stacks

```
stacks/
├── foundation/
│   ├── network/          # VPC, subnets, NAT gateways, security groups
│   └── iam/              # IAM roles and policies
├── platform/
│   ├── containers/       # EKS cluster, node groups, ECR
│   └── data/             # RDS, ElastiCache, DynamoDB
├── application/
│   ├── compute/          # ALB, Auto Scaling Groups, Lambda
│   └── storage/          # S3 buckets, EFS
└── observability/
    └── monitoring/       # CloudWatch, Prometheus, alerting
```

## Prerequisites

- Terraform >= 1.6
- AWS CLI configured with appropriate profiles
- TFLint with AWS ruleset (optional, for linting)

## Quick Start

```bash
# 1. Clone and configure
git clone <repository-url>
cd terraform_scaffold_project

# 2. Initialize TFLint plugins
tflint --init

# 3. Work on a stack
cd stacks/foundation/network

# 4. Copy and configure backend
cp backend.tf.example backend.tf
# Edit backend.tf with your bucket/key

# 5. Init, plan, apply
terraform init
terraform plan -var-file=../../../common/common.tfvars \
               -var-file=../../../environments/dev/foundations.tfvars
terraform apply -var-file=../../../common/common.tfvars \
                -var-file=../../../environments/dev/foundations.tfvars
```

## Project Structure

```
.
├── providers.tf                # Root provider config (reference)
├── versions.tf                 # Terraform & provider version constraints
├── backend.tf.example          # Backend template (copy to backend.tf)
├── common/
│   ├── common.tfvars           # Shared variable values
│   └── variables.tf            # Shared variable definitions
├── environments/
│   ├── dev/                    # Dev environment overrides
│   ├── qa/                     # QA environment overrides
│   └── prd/                    # Production environment overrides
├── stacks/                     # Infrastructure stacks (see Architecture)
├── docs/                       # Documentation and catalog
└── .kiro/
    ├── steering/               # AI agent steering rules
    ├── skills/                 # AI agent skills
    ├── agents/                 # Agent configurations
    └── settings/               # MCP settings
```

## Environments

Configuration follows a hierarchical precedence (highest to lowest):

1. `environments/{env}/*.tfvars` — Environment-specific overrides
2. `common/common.tfvars` — Shared values
3. Stack-level `variables.tf` defaults

Each environment directory contains layer-specific tfvars:

```
environments/dev/
├── foundations.tfvars
├── platform.tfvars
├── applications.tfvars
└── observability.tfvars
```

## Stack Convention

Every stack contains:

| File | Purpose |
|------|---------|
| `main.tf` | Resource/module definitions |
| `variables.tf` | Input variables |
| `outputs.tf` | Output values |
| `versions.tf` | Terraform & provider constraints |
| `providers.tf` | Provider configuration |
| `backend.tf.example` | Backend template |

## Linting

This scaffold ships with [tflint-ruleset-aws](https://github.com/terraform-linters/tflint-ruleset-aws) pre-configured:

```bash
# Initialize plugins
tflint --init

# Lint all stacks
tflint --recursive

# Pre-commit hooks
pre-commit install
pre-commit run --all-files
```

## Versioning

This project uses **IaC Tagging Code** (MAJOR.MINOR.PATCH):

- **MAJOR** — Environment additions/removals, framework changes
- **MINOR** — New stacks, modules, or resources (backward compatible)
- **PATCH** — Bug fixes, config tuning, documentation

Commits follow [Conventional Commits](https://www.conventionalcommits.org/).

## License

Apache-2.0
