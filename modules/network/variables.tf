variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type = string
}

variable "public_subnets" {
  description = "Public subnet CIDR blocks"
  type = list(string)
}

variable "private_subnets" {
    description = "List of private subnet CIDRs"
    type = list(string)
}

variable "availability_zones" {
    description = "List of availability zones to use"
    type = list(string)
}