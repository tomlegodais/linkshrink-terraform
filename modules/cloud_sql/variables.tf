variable "database_name" {
  description = "The name of the instance and database to create"
  type        = string
}

variable "region" {
  description = "The region in which to create the instance"
  type        = string
}

variable "environment" {
  description = "The environment in which the resources are created"
  type        = string
}

variable "postgres_root_password_secret_id" {
  description = "The ID of the secret containing the Postgres root password"
  type        = string
}

variable "app_user_password_secret_id" {
  description = "The ID of the secret containing the app user password"
  type        = string
}

variable "vpc_self_link" {
  description = "The self link of the VPC network to which the instance should be connected"
  type        = string
}
