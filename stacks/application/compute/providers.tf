provider "aws" {
  region  = var.region
  profile = var.deployment_profile

  default_tags {
    tags = {
      Environment = var.environment
      ManagedBy   = "terraform"
      Project     = var.project_name
    }
  }
}

variable "deployment_profile" {
  description = "AWS CLI profile"
  type        = string
  default     = "default"
}
