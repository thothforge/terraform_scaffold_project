variable "project_name" {
  description = "Project name used for resource naming and tagging"
  type        = string
}

variable "environment" {
  description = "Environment name (dev, qa, prd)"
  type        = string
  validation {
    condition     = contains(["dev", "qa", "stg", "test", "prod", "prd"], var.environment)
    error_message = "Environment must be one of: dev, qa, stg, test, prod, prd."
  }
}

variable "region" {
  description = "AWS region for deployment"
  type        = string
  default     = "us-east-2"
}

variable "deployment_profile" {
  description = "AWS CLI profile for deployment"
  type        = string
  default     = "default"
}

variable "owner" {
  description = "Team or role owner for this deployment"
  type        = string
  default     = "platform-team"
}
