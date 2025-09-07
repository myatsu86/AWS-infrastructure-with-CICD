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
