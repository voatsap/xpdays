## Application version stuff

variable "xpdays_versiontag" {}

## VPC related stuff

variable "region" {
  type        = "map"
  default     = {}
  description = "The AWS region."
}
variable "environment" {
  description = "The Environment Type"
  default     = "production"
}
variable "vpc_cidr" {
  type        = "map"
  description = "Target VPC default CIDR block"
  default     = {}
}
variable "default_subnet_cidr_block" {
  type        = "map"
  description = "The default public local subnet CIDR"
  default     = {}
}
variable "default_db_subnet_cidr_block" {
  type        = "map"
  description = "The default public local subnet CIDR"
  default     = {}
}
variable "default_subnet_availability_zone" {
  type        = "map"
  description = "The defaultu environemnt AZ"
  default     = {}
}
variable "default_db_subnet_availability_zone" {
  type        = "map"
  description = "The defaultu environemnt AZ"
  default     = {}
}

## Instance definition
 
variable "instance_type" {
  type    = "map"
  default = {}
}

variable "asg_enabled_metrics" {
  type    = "list"
}  
variable "instance_suffix" {
  type = "list"
  description = "Add instance suffix"
}

variable "instance_count_xpdays_min" {
  type    = "map"
  default = {}
}
variable "instance_count_xpdays_max" {
   type    = "map"
   default = {}
}
variable "instance_count_xpdays_desired" {
   type    = "map"
   default = {}
}

