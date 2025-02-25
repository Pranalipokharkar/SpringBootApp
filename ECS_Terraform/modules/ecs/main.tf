resource "aws_ecs_cluster" "cluster" {
  name = var.cluster_name
}

resource "aws_cloudwatch_log_group" "ecs_log_group" {
  name              = "/ecs/java-app"
  retention_in_days = 7
}

resource "aws_ecs_task_definition" "java" {
  family                   = "java-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.cpu
  memory                   = var.memory
  execution_role_arn       = var.ecs_task_execution_role_arn    #...................................
  container_definitions = jsonencode([
    {
      name      = "java"
      image     = var.ecr_repo_url
      cpu       = var.cpu
      memory    = var.memory
      essential = true

      logConfiguration = {
        logDriver = "awslogs",
        options = {
          "awslogs-group"         = aws_cloudwatch_log_group.ecs_log_group.name,
          "awslogs-region"        = "us-east-1",
          "awslogs-stream-prefix" = "ecs"
        }
      }
      portMappings = [
        {
          containerPort = var.container_port
          hostPort      = var.host_port
        }
      ]
    }
  ])
}

resource "aws_ecs_service" "java" {
  name            = "java-service"
  cluster         = aws_ecs_cluster.cluster.id
  task_definition = aws_ecs_task_definition.java.arn
  launch_type     = "FARGATE"
  desired_count   = var.desired_count

  network_configuration {
    subnets         = var.private_subnet_id
    security_groups = [var.ecs_sg_id]
  }

    load_balancer {
    target_group_arn = var.target_group_arn      #..................................................
    container_name   = "java"
    container_port   = var.container_port
  }

}
