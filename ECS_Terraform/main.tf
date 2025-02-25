#Remote Backend

terraform {
  backend "s3" {
    bucket         = "tf-java-state-bucket"
    key           = "terraform.tfstate"
    region        = "us-east-1"
    encrypt       = true
    dynamodb_table = "terraform-locks"
  }
}

module "vpc" {
  source               = "./modules/vpc"
  vpc_cidr            = var.vpc_cidr
  project_name        = var.project_name
  public_subnet_cidr  = var.public_subnet_cidr
  private_subnet_cidr = var.private_subnet_cidr
  availability_zone   = var.availability_zone
}

module "security" {
  source         = "./modules/security"
  vpc_id        = module.vpc.vpc_id
  container_port = var.container_port
  project_name   = var.project_name
}

module "iam" {
  source       = "./modules/IAM role"
  project_name = var.project_name
}

module "ecr" {
  source    = "./modules/ecr"
  repo_name = var.repo_name
}

module "alb" {
  source            = "./modules/alb"
  vpc_id           = module.vpc.vpc_id
  alb_sg_id        = module.security.alb_sg_id
  alb_listener_port = var.alb_listener_port
  public_subnet_id  = module.vpc.public_subnet_id
  project_name      = var.project_name
}

module "ecs" {
  source                     = "./modules/ecs"
  cluster_name               = var.cluster_name
  cpu                        = var.cpu
  memory                     = var.memory
  ecr_repo_url               = module.ecr.ecr_repo_url
  private_subnet_id          = module.vpc.private_subnet_id
  ecs_sg_id                  = module.security.ecs_sg_id
  container_port             = var.container_port
  host_port                  = var.host_port
  desired_count              = var.desired_count
  ecs_task_execution_role_arn = module.iam.ecs_task_execution_role_arn
  target_group_arn           = module.alb.target_group_arn
}

module "autoscaling" {
  source             = "./modules/auto_scaling"
  ecs_service       = module.ecs.ecs_service
  ecs_cluster       = module.ecs.ecs_cluster
  min_task_count    = var.min_task_count
  max_task_count    = var.max_task_count
  cpu_target_value  = var.cpu_target_value
  memory_target_value = var.memory_target_value
}
