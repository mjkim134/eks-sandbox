data "aws_route53_zone" "my_domain" {
  name         = "mjkim.click"
  private_zone = false
}

module "external_dns_irsa" {
  source = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts"

  name = "external-dns"

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