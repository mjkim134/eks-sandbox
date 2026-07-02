region = "ap-northeast-2"

cluster_name    = "hyumin-dev"
cluster_version = "1.35"
instance_types  = ["t3a.medium", "t3.medium"]
capacity_type   = "SPOT"
min_size        = 2
max_size        = 3
desired_size    = 2
my_ip_cidr      = ["222.121.125.201/32"]

environment = "dev"
project     = "eks-sandbox"
owner       = "hyumin"
