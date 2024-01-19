variable "region" {
  description = "The region to deploy to"
  type        = string
}

variable "project_id" {
  description = "The ID of the project to deploy to"
  type        = string
}

variable "environment" {
  description = "The environment to deploy to"
  type        = string
}

variable "name" {
  description = "The name of the deployment"
  type        = string
}

variable "dockerimage" {
  description = "The deployment docker image URL"
  type        = string
}

variable "vpc_connector" {
  description = "The name of the VPC connector"
  type        = string
}

variable "postgres_db" {
  description = "The PostgreSQL database to connect to"
  type = object({
    host               = string
    name               = string
    username           = string
    password_secret_id = string
  })
}

variable "redis_url" {
  description = "The URL of the Redis instance"
  type        = string
}
