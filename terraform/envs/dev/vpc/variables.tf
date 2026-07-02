variable "region" {
  type = string
}

variable "cluster_name" {
  type = string
}

variable "vpc_cidr" {
  type = string
}

variable "enable_nat_gateway" {
  type = bool
}

variable "single_nat_gateway" {
  type = bool
}

variable "one_nat_gateway_per_az" {
  type = bool
}

variable "environment" {
  type = string
}

variable "project" {
  type = string
}

variable "owner" {
  type    = string
  default = "default"
}