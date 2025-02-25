aws_region = "us-east-1"

vpc_cidr            = "10.0.0.0/16"
project_name        = "java"
public_subnet_cidr  = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnet_cidr = ["10.0.4.0/24", "10.0.5.0/24"]
availability_zone  = ["us-east-1a", "us-east-1b",]

container_port      = 80
alb_listener_port   = 80

cluster_name        = "java-cluster"
cpu                = 1024
memory             = 4096 
repo_name          = "springboot-repo"

host_port          = 80
desired_count      = 2

min_task_count     = 1
max_task_count     = 5
cpu_target_value   = 90
memory_target_value = 75

