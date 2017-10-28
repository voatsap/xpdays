variable "region" {
  type        = "string"
  default     = "eu-central-1"
  description = "The AWS region"
}

variable "environment" {
  description = "The Environment Type"
  default     = "production"
}

variable "vpc_security_group_ids" {
  type    = "list"
}

variable "instance_type" {
  type    = "map"
  default = {}
}

variable "vpc_security_group_ids_map" {
  type    = "map"
  default = {}
}
