# Project Structure

## Directory Layout

```
terraform_scaffold_project/
├── .tflint.hcl                 # TFLint config (AWS + Terraform rulesets)
├── .pre-commit-config.yaml     # Pre-commit hooks
├── .gitignore
├── .thothcf.toml               # ThothCTL template config
├── providers.tf                # Root provider reference
├── versions.tf                 # Root version constraints
├── backend.tf.example          # Backend template
├── common/
│   ├── common.tfvars           # Shared variable values
│   └── variables.tf            # Shared variable definitions
├── environments/
│   ├── dev/
│   │   ├── foundations.tfvars
│   │   ├── platform.tfvars
│   │   ├── applications.tfvars
│   │   └── observability.tfvars
│   ├── qa/
│   └── prd/
├── stacks/
│   ├── foundation/
│   │   ├── network/            # VPC, subnets, NAT, security groups
│   │   └── iam/                # Roles, policies
│   ├── platform/
│   │   ├── containers/         # EKS, ECR
│   │   └── data/               # RDS, ElastiCache
│   ├── application/
│   │   ├── compute/            # ALB, ASG, Lambda
│   │   └── storage/            # S3, EFS
│   └── observability/
│       └── monitoring/         # CloudWatch, Prometheus
├── docs/
│   └── catalog/                # Backstage catalog integration
└── .kiro/
    ├── steering/               # AI steering docs (this dir)
    ├── agents/
    ├── settings/
    └── skills/
```

## Stack File Convention

Each stack directory contains:
- `main.tf` — Resources and module calls
- `variables.tf` — Input variables
- `outputs.tf` — Exported values for dependent stacks
- `versions.tf` — Terraform and provider version constraints
- `providers.tf` — Provider configuration
- `backend.tf.example` — Backend template (copy to backend.tf)

## Dependency Order

Stacks should be deployed in this order:
1. `foundation/network` → `foundation/iam`
2. `platform/containers` → `platform/data`
3. `application/compute` → `application/storage`
4. `observability/monitoring`

Cross-stack references use `terraform_remote_state` data sources or SSM parameters.
