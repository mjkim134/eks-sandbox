variable "region" {
  type = string
}

variable "cluster_name" {
  type = string
}

variable "cluster_version" {
  type = string
}

variable "instance_types" {
  type = list(string)
}

variable "capacity_type" {
  type = string
}

variable "min_size" {
  type = number
}

variable "max_size" {
  type = number
}

variable "desired_size" {
  type = number
}

variable "endpoint_private_access" {
  type = bool
}

variable "endpoint_public_access" {
  type = bool
}

variable "my_ip_cidr" {
  type = list(string)
}

variable "environment" {
  type = string
}

variable "project" {
  type = string
}

variable "owner" {
  type = string
}