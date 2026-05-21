# resource "aws_eks_addon" "aws_ebs_csi_driver" {
#   cluster_name             = module.eks.cluster_name
#   addon_name               = "aws-ebs-csi-driver"
#   addon_version            = "v1.59.0-eksbuild.1"
# }