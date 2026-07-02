module "vpc" {
  source = "../../../modules/vpc"

  cluster_name = var.cluster_name
  region       = var.region
  vpc_cidr     = var.vpc_cidr

  enable_nat_gateway     = var.enable_nat_gateway
  single_nat_gateway     = var.single_nat_gateway
  one_nat_gateway_per_az = var.one_nat_gateway_per_az
}