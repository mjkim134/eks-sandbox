module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "21.17.1"

  name               = local.name
  kubernetes_version = local.cluster_version

  endpoint_public_access                   = true
  enable_cluster_creator_admin_permissions = true

  # EKS Addons
  addons = {
    coredns = {}
    kube-proxy = {}
    vpc-cni = {
      before_compute = true

      configuration_values = jsonencode({
        env = {
          ENABLE_PREFIX_DELEGATION = "true"
          WARM_PREFIX_TARGET       = "1"
        }
      })
    }
  }

  vpc_id                   = module.vpc.vpc_id
  subnet_ids               = module.vpc.private_subnets
  control_plane_subnet_ids = module.vpc.intra_subnets

  eks_managed_node_groups = {
    karpenter = {
      name            = "karpenter"
      use_name_prefix = false

      # Starting on 1.30, AL2023 is the default AMI type for EKS managed node groups
      ami_type       = "AL2023_x86_64_STANDARD"
      instance_types = ["t3a.medium", "t3.medium"]
      capacity_type  = "SPOT"

      min_size = 2
      max_size = 3
      desired_size = 2

      subnet_ids = module.vpc.private_subnets
      disk_size = 40

      ebs_optimized           = true

      tags = { Name = "karpenter" }
    }
  }

  tags = local.tags
}

################################################################################
# VPC
################################################################################

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 6.0"

  name = local.name
  cidr = local.vpc_cidr

  azs             = local.azs
  private_subnets = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 4, k)]
  public_subnets  = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 8, k + 48)]
  intra_subnets   = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 8, k + 52)]

  enable_nat_gateway = true
  single_nat_gateway = true
  one_nat_gateway_per_az = false

  public_subnet_tags = {
    "kubernetes.io/role/elb" = 1
  }

  private_subnet_tags = {
    "kubernetes.io/role/internal-elb" = 1
  }

  tags = local.tags
}

# module "aws_vpc_cni_ipv4_pod_identity" {
#   source  = "terraform-aws-modules/eks-pod-identity/aws"
#   version = "~> 2.6"

#   name = "aws-vpc-cni-ipv4"

#   attach_aws_vpc_cni_policy = true
#   aws_vpc_cni_enable_ipv4   = true

#   # Pod Identity Associations
#   association_defaults = {
#     namespace       = "kube-system"
#     service_account = "aws-node"
#   }

#   associations = {
#     kimpala-dev = {
#       cluster_name = module.eks.cluster_name
#     }
#   }

#   tags = local.tags
# }

# module "ebs_kms_key" {
#   source  = "terraform-aws-modules/kms/aws"
#   version = "~> 1.5"

#   description = "Customer managed key to encrypt EKS managed node group volumes"

#   # Policy
#   key_administrators = [
#     data.aws_caller_identity.current.arn
#   ]

#   key_service_roles_for_autoscaling = [
#     # required for the ASG to manage encrypted volumes for nodes
#     "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/aws-service-role/autoscaling.amazonaws.com/AWSServiceRoleForAutoScaling",
#     # required for the cluster / persistentvolume-controller to create encrypted PVCs
#     module.eks.cluster_iam_role_arn,
#   ]

#   # Aliases
#   aliases = ["eks/${local.name}/ebs"]

#   tags = local.tags
# }

# module "key_pair" {
#   source  = "terraform-aws-modules/key-pair/aws"
#   version = "~> 2.0"

#   key_name_prefix    = local.name
#   create_private_key = true

#   tags = local.tags
# }

# resource "aws_iam_policy" "node_additional" {
#   name        = "${local.name}-additional"
#   description = "Example usage of node additional policy"

#   policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Action = [
#           "ec2:Describe*",
#         ]
#         Effect   = "Allow"
#         Resource = "*"
#       },
#     ]
#   })

#   tags = local.tags
# }