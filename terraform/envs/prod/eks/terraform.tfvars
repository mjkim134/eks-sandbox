region = "ap-northeast-2"

cluster_name    = "hyumin-prod"
cluster_version = "1.35"
instance_types  = ["m7i.large"]
capacity_type   = "on-demand"
min_size        = 2
max_size        = 3
desired_size    = 2
my_ip_cidr      = ["222.121.125.201/32"]

environment = "prod"
project     = "eks-sandbox"
owner       = "hyumin"
