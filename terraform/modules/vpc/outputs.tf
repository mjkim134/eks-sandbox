output "vpc_id" {
  description = "The ID of the VPC created for this EKS cluster"
  value       = module.vpc.vpc_id
}

output "private_subnets" {
  description = "List of IDs of private subnets (Used for Node Groups)"
  value       = module.vpc.private_subnets
}

output "intra_subnets" {
  description = "List of IDs of intra subnets (Used for EKS Control Plane)"
  value       = module.vpc.intra_subnets
}