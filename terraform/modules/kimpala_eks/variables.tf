variable "region" {
  description = "The AWS region"
  type        = string
}

variable "cluster_name" {
  description = "Name prefix for resources"
  type        = string
}

variable "cluster_version" {
  description = "EKS Cluster version"
  type        = string
}

variable "vpc_cidr" {
  description = "VPC CIDR block"
  type        = string
}

variable "my_ip_cidr" {
  description = "Allowed CIDR blocks for EKS public endpoint"
  type        = list(string)
  default     = ["127.0.0.1/32"]
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}

variable "instance_types" {
  description = "Instance types for node group"
  type        = list(string)
  default     = ["t3.medium"]
}

variable "capacity_type" {
  description = "Capacity type for node group (SPOT or ON_DEMAND)"
  type        = string
  default     = "SPOT"
}

variable "min_size" {
  description = "Min size of node group"
  type        = number
  default     = 2
}

variable "max_size" {
  description = "Max size of node group"
  type        = number
  default     = 3
}

variable "desired_size" {
  description = "Desired size of node group"
  type        = number
  default     = 2
}

variable "single_nat_gateway" {
  description = "Should be true if you want to provision a single shared NAT Gateway across all of your private networks"
  type        = bool
  default     = true
}

variable "one_nat_gateway_per_az" {
  description = "Should be true if you want only one NAT Gateway per availability zone"
  type        = bool
  default     = false
}

variable "endpoint_public_access" {
  description = "Indicates whether or not the Amazon EKS public API server endpoint is enabled"
  type        = bool
  default     = true
}