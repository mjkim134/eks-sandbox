region = "ap-northeast-2"

cluster_name    = "eks-sandbox-dev"
cluster_version = "1.35"
instance_types  = ["t3a.medium"]
capacity_type   = "SPOT"
min_size        = 2
max_size        = 3
desired_size    = 2

endpoint_private_access = true
endpoint_public_access  = true
my_ip_cidr              = ["x.x.x.x/32"]