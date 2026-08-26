# Product Overview

## Purpose
Pure Terraform scaffold for AWS infrastructure using layered DDD architecture.
No Terragrunt — each stack is independently managed with its own state.

## Key Principles
- **Layer isolation**: Foundation → Platform → Application → Observability
- **Environment parity**: Same stacks across dev/qa/prd via tfvars
- **Explicit state**: Each stack has its own backend configuration
- **Lint-first**: tflint-ruleset-aws enforces AWS best practices at code time

## Target Users
- Platform engineering teams
- DevOps engineers managing AWS with pure Terraform
- Teams that prefer explicit state management over orchestration layers

## Constraints
- AWS only (tflint-ruleset-aws, provider constraints)
- Terraform >= 1.6
- No Terragrunt, no CDK — pure HCL
