variable "cluster_name" {
  description = "Name prefix for resources"
  type        = string
}

variable "cluster_version" {
  description = "EKS Cluster version"
  type        = string
}

variable "my_ip_cidr" {
  description = "Allowed CIDR blocks for EKS public endpoint"
  type        = list(string)
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}

variable "instance_types" {
  description = "Instance types for node group"
  type        = list(string)
}

variable "capacity_type" {
  description = "Capacity type for node group (SPOT or ON_DEMAND)"
  type        = string
}

variable "min_size" {
  description = "Min size of node group"
  type        = number
}

variable "max_size" {
  description = "Max size of node group"
  type        = number
}

variable "desired_size" {
  description = "Desired size of node group"
  type        = number
}

variable "endpoint_private_access" {
  description = "Indicates whether or not the Amazon EKS private API server endpoint is enabled"
  type        = bool
}

variable "endpoint_public_access" {
  description = "Indicates whether or not the Amazon EKS public API server endpoint is enabled"
  type        = bool
}

variable "vpc_id" {
  description = "The ID of the VPC where the cluster will be deployed"
  type        = string
}

variable "private_subnets" {
  description = "A list of private subnet IDs where EKS Node Groups will be placed"
  type        = list(string)
}

variable "intra_subnets" {
  description = "A list of intra subnet IDs for the EKS Control Plane"
  type        = list(string)
}