resource "aws_route53_zone" "www" {
  name = var.domain_name
}

resource "aws_route53_record" "primary" {
  zone_id  = aws_route53_zone.www.zone_id
  name     = var.domain_name
  type     = "A"

  alias {
    name                   = aws_lb.ghost-alb.dns_name
    zone_id                = aws_lb.ghost-alb.zone_id
    evaluate_target_health = true
  }

  failover_routing_policy {
    type = "PRIMARY"
  }

  health_check_id = aws_route53_health_check.ghost.id

  set_identifier = "primary"
}

resource "aws_route53_record" "secondary" {
  zone_id  = aws_route53_zone.www.zone_id
  name     = var.domain_name
  type     = "A"  
  ttl     = "300"
  records = [var.ip]

  failover_routing_policy {
    type = "SECONDARY"
  }

  set_identifier = "secondary"
}

resource "aws_route53_health_check" "ghost" {
  # fqdn              = var.domain_name
  fqdn              = aws_lb.ghost-alb.dns_name
  port              = 80
  type              = "HTTP"
  resource_path     = "/"
  failure_threshold = "5"
  request_interval  = "30"
  tags = {
    Name = "ghost"
  }
}