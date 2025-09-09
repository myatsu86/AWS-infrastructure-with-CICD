# AWS-infrastructure-with-CICD
Multi-tier AWS infrastructure with CI/CD 

AWS VPC Design
Architecture Overview

- VPC: /16 (e.g., 10.0.0.0/16)
- Availability Zones: 2 (e.g., us-east-1a, us-east-1b)
- Subnets:
  - Public (2): /24 each, one in each AZ (for NAT GW, ALB, Bastion, etc.)
  - Private (2): /24 each, one in each AZ (for EC2 app servers or RDS)
- Gateways:
  - 1 Internet Gateway (IGW) – attached to VPC
  - 1 NAT Gateway (cost-aware) – in Public Subnet A only
- Route Tables:
  - Public RT: IGW route (0.0.0.0/0)
  - Private RTs (2): NAT Gateway route for outbound internet

# AWS Network Terraform Module

This module creates a **multi-tier AWS network** with the following:
- 1 VPC
- 2 Public Subnets (across 2 AZs)
- 2 Private Subnets (across 2 AZs)
- 1 Internet Gateway (IGW)
- 1 NAT Gateway (cost-aware: only one NAT in first public subnet)
- Route tables for public & private subnets

## Usage
```hcl
module "network" {
  source            = "./modules/network"
  vpc_cidr          = "10.0.0.0/16"
  public_subnets    = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnets   = ["10.0.101.0/24", "10.0.102.0/24"]
  availability_zones = ["us-east-1a", "us-east-1b"]
}

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
