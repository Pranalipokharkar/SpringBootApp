variable "aws_region" {}
variable "vpc_cidr" {}
variable "project_name" {}
variable "public_subnet_cidr" {type = list(string)}
variable "private_subnet_cidr" {type = list(string)}
variable "availability_zone" {type = list(string)}
variable "container_port" {}
variable "alb_listener_port" {}
variable "cluster_name" {}
variable "cpu" {}
variable "memory" {}
variable "repo_name" {}
variable "host_port" {}
variable "desired_count" {}
variable "min_task_count" {}
variable "max_task_count" {}
variable "cpu_target_value" {}
variable "memory_target_value" {}
