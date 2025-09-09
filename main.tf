module "network" {
    source = "./modules/network"
    vpc_cidr = var.vpc_cidr
    public_subnets = var.public_subnets
    private_subnets = var.private_subnets
    availability_zones = var.availability_zones
}

module "backend" {
  source = "./modules/backend"
  tf_backend_bucket = var.tf_backend_bucket
  env  = var.env
}