output "cluster_name" {
  value       = module.eks.cluster_name
  description = "The name of the EKS cluster"
}

output "cluster_endpoint" {
  value       = module.eks.cluster_endpoint
  description = "The endpoint for the EKS Kubernetes API server"
}

output "cluster_certificate_authority_data" {
  value       = module.eks.cluster_certificate_authority_data
  description = "Base64 encoded certificate data required to communicate with the cluster"
}

output "cluster_primary_security_group_id" {
  value       = module.eks.cluster_primary_security_group_id
  description = "The primary security group ID for EKS cluster and Karpenter nodes"
}

output "vpc_id" {
  value       = module.vpc.vpc_id
  description = "The ID of the VPC created for this EKS cluster"
}
