data "aws_route53_zone" "my_domain" {
  name         = "mjkim.click"
  private_zone = false
}

module "load_balancer_controller_irsa" {
  source = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts"

  name = "${var.cluster_name}-load-balancer-controller-role"
  use_name_prefix = false
  
  attach_load_balancer_controller_policy = true

  oidc_providers = {
    this = {
      provider_arn               = module.eks.oidc_provider_arn
      namespace_service_accounts = ["kube-system:aws-load-balancer-controller"]
    }
  }

  tags = var.tags
}

module "ebs_csi_irsa" {
  source = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts"

  name = "${var.cluster_name}-ebs-csi-role"
  use_name_prefix = false

  attach_ebs_csi_policy = true

  oidc_providers = {
    this = {
      provider_arn               = module.eks.oidc_provider_arn
      namespace_service_accounts = ["kube-system:ebs-csi-controller-sa"]
    }
  }

  tags = var.tags
}

module "external_dns_irsa" {
  source = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts"

  name = "${var.cluster_name}-external-dns-role"
  use_name_prefix = false

  attach_external_dns_policy    = true
  external_dns_hosted_zone_arns = [data.aws_route53_zone.my_domain.arn]

  oidc_providers = {
    this = {
      provider_arn               = module.eks.oidc_provider_arn
      namespace_service_accounts = ["kube-system:external-dns"]
    }
  }

  tags = var.tags
}

module "vpc_cni_ipv4_irsa" {
  source = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts"

  name = "${var.cluster_name}-vpc-cni-ipv4-role"
  use_name_prefix = false

  attach_vpc_cni_policy = true
  vpc_cni_enable_ipv4   = true

  oidc_providers = {
    this = {
      provider_arn               = module.eks.oidc_provider_arn
      namespace_service_accounts = ["kube-system:aws-node"]
    }
  }

  tags = var.tags
}