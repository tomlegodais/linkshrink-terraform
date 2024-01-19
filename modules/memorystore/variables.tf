variable "name" {
  description = "The name of the redis instance"
  type        = string
}

variable "environment" {
  description = "The environment to deploy the redis instance to"
  type        = string
}

variable "region" {
  description = "The region to deploy the redis instance to"
  type        = string
}

variable "vpc_self_link" {
  description = "The self link of the VPC network to which the instance should be connected"
  type        = string
}
