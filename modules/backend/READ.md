# Terraform Backend Module

This module creates:
- **S3 bucket** for storing Terraform state
- **DynamoDB table (optional)** for state locking

## Usage
```hcl
module "backend" {
  source         = "./modules/backend"
  project_name   = "multi-tier-aws"
  environment    = "dev"
  enable_locking = true
}
