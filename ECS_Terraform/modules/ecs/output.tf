output "ecs_cluster" {
  value = aws_ecs_cluster.cluster.id
}

output "ecs_service" {
  value = aws_ecs_service.java.name    #.........................
}
