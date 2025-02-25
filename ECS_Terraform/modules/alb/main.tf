resource "aws_lb" "alb" {
  name               = "app-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.alb_sg_id]
  subnets           = var.public_subnet_id

    tags = {
    Name = "${var.project_name}-alb"
  }
}

resource "aws_lb_target_group" "tg" {
  name     = "app-tg"
  port     = var.alb_listener_port
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  target_type = "ip"

    health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
    matcher             = "200"
  }

    tags = {
    Name = "${var.project_name}-tg"
}
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.alb.arn
  port              = var.alb_listener_port
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg.arn
  }
}
