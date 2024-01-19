variable "project_id" {
  description = "The GCP project ID to deploy to"
  type        = string
}

variable "region" {
  description = "The GCP region to deploy to"
  type        = string
}

variable "environment" {
  description = "The app environment to deploy to"
  type        = string
}

variable "service_version" {
  description = "The version of the service to deploy"
  type        = string
}

variable "subnet_cidr" {
  description = "The subnet CIDR for the VPC"
  type        = string
}

variable "vpc_connector_cidr" {
  description = "The CIDR for the VPC connector"
  type        = string
}

variable "gcp_tf_infra_operator_key" {
  description = "The GCP service account key for the Terraform infra operator"
  type        = string
  sensitive   = true
}
