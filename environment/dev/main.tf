
module "network" {
  source = "../../modules/network"

  aws_region           = var.aws_region
  env_name             = var.env_name
  vpc_cidr             = var.vpc_cidr
  public_subnet_cidr   = var.public_subnet_cidr
  private_subnet_cidrs = var.private_subnet_cidrs
}