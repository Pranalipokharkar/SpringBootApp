variable "cluster_name" {}
variable "cpu" {}
variable "memory" {}
variable "ecr_repo_url" {}
variable "private_subnet_id" {type = list(string)}
variable "ecs_sg_id" {}
variable "container_port" {}
variable "host_port" {}
variable "desired_count" {}
variable "ecs_task_execution_role_arn" {}
variable "target_group_arn" {}
