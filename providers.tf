provider "aws" {
  region  = var.region
  profile = var.deployment_profile

  default_tags {
    tags = {
      Environment = var.environment
      ManagedBy   = "terraform"
      Project     = var.project_name
      Owner       = var.owner
    }
  }
}
