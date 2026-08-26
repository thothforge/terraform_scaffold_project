# IaC Rules for AI Agents

## Architecture
- Layered DDD: Foundation → Platform → Application → Observability
- Each stack is independently deployed with its own state
- Cross-stack references via `terraform_remote_state` or AWS SSM Parameter Store

## Terraform Standards
- Use `terraform fmt` style
- Pin all module and provider versions exactly
- Every variable must have `description` and `type`
- Every output must have `description`
- Use `validation` blocks for input constraints

## Security
- No hardcoded secrets — use AWS Secrets Manager or SSM
- Enable encryption at rest for all storage
- Least-privilege IAM policies (no wildcard actions in prod)
- Mark sensitive outputs with `sensitive = true`

## Naming
- Resources: `snake_case`
- Variables/outputs: `snake_case`
- State key: `stacks/<layer>/<component>/terraform.tfstate`

## Modules
- Approved sources: `terraform-aws-modules` registry
- Pin versions (e.g., `version = "5.7.0"`, not `">= 5.0"`)
- Local modules in `modules/` directory within the stack

## Commits
- Conventional Commits: `feat:`, `fix:`, `chore:`, `docs:`
- Tags: `vMAJOR.MINOR.PATCH`
