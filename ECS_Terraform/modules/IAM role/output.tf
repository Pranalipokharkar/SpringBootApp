output "ecs_task_execution_role_name" {
  description = "The name of the ECS Task Execution IAM Role"
  value       = aws_iam_role.ecs_task_execution_role.name
}

output "ecs_task_execution_role_arn" {
  description = "The ARN of the ECS Task Execution IAM Role"
  value       = aws_iam_role.ecs_task_execution_role.arn
}
