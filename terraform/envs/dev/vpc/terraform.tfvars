region = "ap-northeast-2"

cluster_name = "eks-sandbox-dev"
vpc_cidr     = "10.120.0.0/16"

enable_nat_gateway     = false
single_nat_gateway     = true
one_nat_gateway_per_az = false

environment = "dev"
project     = "eks-sandbox"
owner       = "minystic"