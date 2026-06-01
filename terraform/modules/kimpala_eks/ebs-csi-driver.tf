# module "ebs_csi_irsa" {
#   source = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts"

#   name = "ebs-csi"

#   attach_ebs_csi_policy = true

#   oidc_providers = {
#     this = {
#       provider_arn               = module.eks.oidc_provider_arn
#       namespace_service_accounts = ["kube-system:ebs-csi-controller-sa"]
#     }
#   }

#   tags = var.tags
# }