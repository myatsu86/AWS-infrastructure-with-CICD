variable "aws_region" {
    description = "AWS region to deploy resources"
    type = string
    default = "ap-southeast-1"
}

variable "project_name" {
    description = "Project Name"
    type = string
    default = "Multi-tier AWS infrastructure with CICD"
}

variable "env" {
    description = "Working/Developing env (dev,stage,prod)"
    type = string
    default = "dev"
}

variable "tf_backend_bucket" {
  description = "Name of the S3 bucket for Terraform state"
  type        = string
  default     = "multi-tier-aws-tf-state"
}

variable "vpc_cidr" {
    description = "CIDR block for the VPC"
    type = string
    default = "10.0.0.0/16"
}

variable "public_subnets" {
    description = "List of public subnet CIDRs"
    type = list(string)
    default = [ "10.0.1.0/24", "10.0.2.0/24" ]
}

variable "private_subnets" {
    description = "List of private subnet CIDRs"
    type = list(string)
    default = ["10.0.101.0/24", "10.0.102.0/24"]
}

variable "availability_zones" {
    description = "List of availability zones to use"
    type = list(string)
    default = ["ap-southeast-1a", "ap-southeast-1b"]
  
}