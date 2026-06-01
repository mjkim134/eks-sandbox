output "cluster_name" {
  value       = module.kimpala_eks.cluster_name
  description = "The name of the EKS cluster"
}

output "cluster_endpoint" {
  value       = module.kimpala_eks.cluster_endpoint
  description = "The endpoint for the EKS Kubernetes API server"
}

output "cluster_certificate_authority_data" {
  value       = module.kimpala_eks.cluster_certificate_authority_data
  description = "Base64 encoded certificate data required to communicate with the cluster"
}

output "cluster_primary_security_group_id" {
  value       = module.kimpala_eks.cluster_primary_security_group_id
  description = "The primary security group ID for Karpenter nodes"
}

output "vpc_id" {
  value       = module.kimpala_eks.vpc_id
  description = "The ID of the VPC"
}
