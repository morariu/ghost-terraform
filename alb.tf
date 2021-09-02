resource "aws_lb" "ghost-alb" {
  name               = "ghost-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.ghost-web.id]

  enable_deletion_protection = false

  subnet_mapping {
    subnet_id        = aws_subnet.subnet1.id
  }

  subnet_mapping {
    subnet_id        = aws_subnet.subnet2.id
  }

  tags = {
    Name = "ghost"
  }
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.ghost-alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ghost-tg.arn
  }
}

resource "aws_lb_target_group" "ghost-tg" {
  name     = "ghost-tg"
  target_type = "instance"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id

  health_check {
      path = "/"
      timeout = "5"
      matcher = "200"
  }

}