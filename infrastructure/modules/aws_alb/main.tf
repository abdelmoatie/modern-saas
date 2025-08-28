resource "aws_security_group" "alb_sg" {
  name        = "alb-security-group"
  description = "Allow HTTP traffic to ALB"
  vpc_id      = var.my_vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow traffic from anywhere
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # Allow all outbound traffic
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "alb-security-group"
  }
}

resource "aws_lb" "application_lb" {
  name               = "my-application-lb"
  internal           = false # Set to true for internal ALB
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = [var.public_subnet_id01,var.public_subnet_id02]
}

resource "aws_lb_target_group" "staging" {
  name     = "tg-staging"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.my_vpc_id
  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

resource "aws_lb_target_group" "prod" {
  name     = "tg-prod"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.my_vpc_id
  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

resource "aws_lb_listener" "http_listener" {
  load_balancer_arn = aws_lb.application_lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.prod.arn
  }
}

resource "aws_lb_listener_rule" "staging" {
  listener_arn = aws_lb_listener.http_listener.arn
  priority     = 10

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.staging.arn
  }

  condition {
    path_pattern {
      values = ["/staging*"]
    }
  }
}

resource "aws_lb_target_group_attachment" "staging_ec2" {
  target_group_arn = aws_lb_target_group.staging.arn
  target_id        = var.staging_ec2_id
  port             = 80
}

resource "aws_lb_target_group_attachment" "production_ec2" {
  target_group_arn = aws_lb_target_group.prod.arn
  target_id        = var.production_ec2_id
  port             = 80
}

output "lb_dns" {
  value = aws_lb.application_lb.dns_name
}
