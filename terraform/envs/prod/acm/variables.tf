variable "environment" {
  description = "The environment name"
  type        = string
}

variable "project" {
  description = "The project name"
  type        = string
}

variable "owner" {
  description = "The owner name"
  type        = string
}

variable "tags" {
  description = "Tags for the ACM certificate"
  type        = map(string)
  default     = {}
}