module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 21.0"

  name               = var.cluster_name
  kubernetes_version = var.cluster_version

  access_entries = {
    cluster_name  = var.cluster_name
    principal_arn = aws_iam_role.karpenter_node.arn
    type          = "EC2_LINUX"
  }

  enable_auto_mode_custom_tags = false
  enable_kms_key_rotation      = false

  authentication_mode                      = "API"
  enable_irsa                              = true
  enable_cluster_creator_admin_permissions = true
  endpoint_private_access                  = var.endpoint_private_access
  endpoint_public_access                   = var.endpoint_public_access
  endpoint_public_access_cidrs             = var.my_ip_cidr

  attach_encryption_policy = false
  encryption_config        = null

  create_iam_role       = true
  iam_role_use_name_prefix = false

  create_node_iam_role  = false
  create_kms_key        = false
  create_security_group = true

  security_group_tags = {
    "kubernetes.io/cluster/${var.cluster_name}" = "owned"
  }

  create_node_security_group = true

  node_security_group_tags = {
    "karpenter.sh/discovery"                    = var.cluster_name
    "kubernetes.io/cluster/${var.cluster_name}" = "owned"
  }

  addons = {
    coredns    = {
      configuration_values = jsonencode({
        nodeSelector = {
          "eks.amazonaws.com/nodegroup" = "init"
        }
      })
    }
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
    aws-ebs-csi-driver = {
      most_recent = true

      service_account_role_arn = module.ebs_csi_irsa.arn
    }
  }

  vpc_id                   = var.vpc_id
  subnet_ids               = var.private_subnets
  control_plane_subnet_ids = var.intra_subnets

  eks_managed_node_groups = {
    init = {
      create_launch_template          = true
      use_custom_launch_template      = true
      launch_template_use_name_prefix = false

      iam_role_attach_cni_policy = false

      name            = "init"
      use_name_prefix = false

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

      iam_role_use_name_prefix = false

      create_security_group = false

      enable_efa_only = false

      block_device_mappings = {
        xvda = {
          device_name = "/dev/xvda"
          ebs = {
            volume_type           = "gp3"
            encrypted             = true
            delete_on_termination = true
          }
        }
      }

      taints = {
        addons = {
          key    = "CriticalAddonsOnly"
          effect = "NO_SCHEDULE"
        }
      }

      metadata_options = {
        http_endpoint               = "enabled"
        http_tokens                 = "required"
        http_put_response_hop_limit = 1
      }

      subnet_ids = var.private_subnets

      tags = {
        Name                                        = "init"
        "kubernetes.io/cluster/${var.cluster_name}" = "owned"
      }
    }
  }

  tags = var.tags
}