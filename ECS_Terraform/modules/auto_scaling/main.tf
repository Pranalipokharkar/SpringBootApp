#If CPU exceeds var.cpu_target_value, ECS adds more tasks (scaling out).
#If CPU drops below var.cpu_target_value, ECS removes tasks (scaling in).
#If Memory usage exceeds var.memory_target_value, ECS adds more tasks.
#If Memory drops below var.memory_target_value, ECS removes tasks.


resource "aws_appautoscaling_target" "ecs_target" {
  service_namespace  = "ecs"
  resource_id        = "service/${var.ecs_cluster}/${var.ecs_service}"

  scalable_dimension = "ecs:service:DesiredCount"
  min_capacity       = var.min_task_count
  max_capacity       = var.max_task_count
}

resource "aws_appautoscaling_policy" "cpu_scaling" {
  name               = "ecs-cpu-scaling"
  service_namespace  = "ecs"
  resource_id        = aws_appautoscaling_target.ecs_target.resource_id
  scalable_dimension = aws_appautoscaling_target.ecs_target.scalable_dimension
  policy_type        = "TargetTrackingScaling"

  target_tracking_scaling_policy_configuration {
    target_value = var.cpu_target_value
    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageCPUUtilization"
    }
  }
}

resource "aws_appautoscaling_policy" "memory_scaling" {
  name               = "ecs-memory-scaling"
  service_namespace  = "ecs"
  resource_id        = aws_appautoscaling_target.ecs_target.resource_id
  scalable_dimension = aws_appautoscaling_target.ecs_target.scalable_dimension
  policy_type        = "TargetTrackingScaling"

  target_tracking_scaling_policy_configuration {
    target_value = var.memory_target_value
    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageMemoryUtilization"
    }
  }
}
