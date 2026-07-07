data "aws_route53_zone" "route53_zone" {
  name         = "mjkim.click"
  private_zone = false
}

module "acm" {
  source = "terraform-aws-modules/acm/aws"
  version = "~> 6.0"

  domain_name = "mjkim.click"
  zone_id     = data.aws_route53_zone.route53_zone.zone_id

  validation_method = "DNS"

  subject_alternative_names = [
    "*.mjkim.click",
  ]

  wait_for_validation = true
}