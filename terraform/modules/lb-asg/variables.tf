variable "environment" {
  description = "The environment name for the resources."
}

variable "vpc_id" {
  description = "The ID of the VPC to use for the resources."
}

variable "subnets" {
  description = "A list of subnet IDs to use for the resources."
  type        = list(string)
}