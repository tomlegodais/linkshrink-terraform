variable "project_id" {
  description = "The project ID to host the network"
  type        = string
}

variable "region" {
  description = "The region to host the network"
  type        = string
}

variable "environment" {
  description = "Environment to use for all resources created by this module"
  type        = string
}

variable "resource_prefix" {
  description = "Prefix to use for all resources created by this module"
  type        = string
}

variable "subnet_cidr" {
  description = "CIDR range for the subnet"
  type        = string
}

variable "vpc_connector_cidr" {
  description = "CIDR range for the VPC connector"
  type        = string
}
