module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 21.0"

  name               = var.cluster_name
  kubernetes_version = var.cluster_version


  enable_auto_mode_custom_tags = false
  enable_kms_key_rotation      = false

  authentication_mode                      = "API"
  enable_irsa                              = true
  enable_cluster_creator_admin_permissions = true
  endpoint_private_access                  = true
  endpoint_public_access                   = var.endpoint_public_access
  endpoint_public_access_cidrs             = var.my_ip_cidr

  attach_encryption_policy = false
  encryption_config        = null

  create_node_iam_role        = false
  create_kms_key              = false
  create_security_group       = true
  create_node_security_group  = true

  node_security_group_tags = {
    "karpenter.sh/discovery" = var.cluster_name
  }

  addons = {
    coredns    = {}
    kube-proxy = {}
    vpc-cni = {
      before_compute = true

      service_account_role_arn = module.vpc_cni_ipv4_irsa.arn

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
    init = {
      create_launch_template     = true
      use_custom_launch_template = true
      iam_role_attach_cni_policy = false

      name = "init"

      instance_types = var.instance_types
      capacity_type  = var.capacity_type

      min_size     = var.min_size
      max_size     = var.max_size
      desired_size = var.desired_size

      create_iam_role        = true
      create_iam_role_policy = true

      iam_role_additional_policies = {
        AmazonSSMManagedInstanceCore = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
      }

      create_security_group = false

      enable_efa_only = false

      block_device_mappings = {
        xvda = {
          device_name = "/dev/xvda"
          ebs = {
            volume_type = "gp3"
            encrypted   = true
          }
        }
      }

      metadata_options = {
      http_endpoint               = "enabled"
      http_tokens                 = "required"
      http_put_response_hop_limit = 2
      }

      subnet_ids = module.vpc.private_subnets

      tags = { Name = "init" }
    }
  }

  tags = var.tags
}