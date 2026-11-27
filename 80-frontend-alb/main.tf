resource "aws_lb" "frontend" {
  name               = "${local.common_name}-frontend" #roboshop-dev-frontend
  internal           = false
  load_balancer_type = "application"
  security_groups    = [local.frontend_alb_sg_id]
  subnets            = local.public_subnet_ids

  enable_deletion_protection = false #should be true in real.but here we need to remove after practice,so keep it false

  tags = merge(
    local.common_tags,
    {
      Name = "${local.common_name}-frontend"
    }
  )
}

resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.frontend.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = local.frontend_alb_certificate_arn

  #default ruel
  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/html"
      message_body = "<h1>Welcome iam from frontend ALB TLS</h1>"
      status_code  = "200"
    }
  }
}
resource "aws_route53_record" "frontend_alb" {
  zone_id = var.zone_id
  name    = "${var.project}-${var.environment}.${var.domain_name}" #roboshop-dev.dewasops.online
  type    = "A"

  alias {
    name                   = aws_lb.frontend.dns_name
    zone_id                = aws_lb.frontend.zone_id
    evaluate_target_health = true
  }
  allow_overwrite = true
}
