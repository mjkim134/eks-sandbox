module "kimpala_eks" {
  source = "../modules/kimpala_eks"

  cluster_name          = "kimpala-dev"
  region                = var.region
  cluster_version       = "1.35"
  vpc_cidr              = "10.120.0.0/16"
  my_ip_cidr            = var.my_ip_cidr

  instance_types = ["t3a.medium", "t3.medium"]
  capacity_type  = "SPOT"
  min_size       = 2
  max_size       = 3
  desired_size   = 2

  single_nat_gateway     = true
  one_nat_gateway_per_az = false
  endpoint_public_access = true

  tags = {
    User = "kimpala"
  }
}