variable "vpc_cidr" {}
variable "project_name" {}

variable "public_subnet_cidr" {type = list(string)}
variable "private_subnet_cidr" {type = list(string)}
variable "availability_zone" {type = list(string)}
