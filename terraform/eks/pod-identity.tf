# module "aws_lb_controller_pod_identity" {
#   source  = "terraform-aws-modules/eks-pod-identity/aws"

#   name = "aws-lbc"

#   attach_aws_lb_controller_policy = true

#   # Pod Identity Associations
#   association_defaults = {
#     namespace       = "kube-system"
#     service_account = "aws-load-balancer-controller"
#   }

#   associations = {
#     kimpala-dev = {
#       cluster_name = module.eks.cluster_name
#     }
#   }

#   tags = local.tags
# }

# module "external_dns_pod_identity" {
#   source  = "terraform-aws-modules/eks-pod-identity/aws"

#   name = "external-dns"

#   attach_external_dns_policy    = true
#   external_dns_hosted_zone_arns = ["arn:aws:route53:::hostedzone/${local.secret_hosted_zone_id}"]

#   # Pod Identity Associations
#   association_defaults = {
#     namespace       = "kube-system"
#     service_account = "external-dns"
#   }

#   associations = {
#     kimpala-dev = {
#       cluster_name = module.eks.cluster_name
#     }
#   }

#   tags = local.tags
# }

# module "aws_ebs_csi_pod_identity" {
#   source  = "terraform-aws-modules/eks-pod-identity/aws"

#   name = "aws-ebs-csi"

#   attach_aws_ebs_csi_policy = true
#   aws_ebs_csi_kms_arns      = ["arn:aws:kms:*:*:key/1234abcd-12ab-34cd-56ef-1234567890ab"]

#   # Pod Identity Associations
#   association_defaults = {
#     namespace       = "kube-system"
#     service_account = "ebs-csi-controller-sa"
#   }

#   associations = {
#     kimpala-dev = {
#       cluster_name = module.eks.cluster_name
#     }
#   }

#   tags = local.tags
# }