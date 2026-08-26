# IaC Rules

## Terraform Style
- Use `terraform fmt` (enforced via pre-commit)
- One resource per file for large stacks; grouped in main.tf for small stacks
- Variables must have `description` and `type`
- Outputs must have `description`
- Use `validation` blocks for input constraints

## Naming Conventions
- Resources: `snake_case` (e.g., `aws_vpc.main`, `aws_subnet.private`)
- Variables: `snake_case`
- Outputs: `snake_case`, prefixed by resource context (e.g., `vpc_id`, `subnet_ids`)
- Files: `snake_case.tf`

## Security Rules
- Never hardcode credentials or secrets in .tf files
- Use `sensitive = true` for secret outputs
- Enable encryption at rest for all storage resources
- Use least-privilege IAM policies
- No wildcard (`*`) in IAM actions for production

## State Management
- One state file per stack (isolated blast radius)
- State key pattern: `stacks/<layer>/<component>/terraform.tfstate`
- Always use DynamoDB locking
- Enable S3 versioning on the state bucket

## Module Usage
- Pin module versions (no floating `main` branch refs)
- Prefer registry modules with version constraints
- Local modules go in a `modules/` directory within the stack

## Versioning & Commits
- Follow Conventional Commits: `feat:`, `fix:`, `chore:`, `docs:`
- Tag releases as `vMAJOR.MINOR.PATCH`
- MAJOR: environment/framework changes
- MINOR: new stacks or resources
- PATCH: fixes, config tuning
