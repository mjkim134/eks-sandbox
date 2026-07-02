region = "ap-northeast-2"

cluster_name = "hyumin-prod"
vpc_cidr     = "10.130.0.0/16"

enable_nat_gateway     = true
single_nat_gateway     = false
one_nat_gateway_per_az = true

environment = "prod"
project     = "eks-sandbox"
owner       = "hyumin"