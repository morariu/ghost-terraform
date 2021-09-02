# Output Values

# VPC
output "vpc" {
  description = "VPC"
  value = aws_vpc.main.id
}

# Subnet EC2-1
output "subnet1" {
  description = "Subnet EC2-1"
  value = aws_subnet.subnet1.id
}

# Subnet EC2-2
output "subnet2" {
  description = "Subnet EC2-2"
  value = aws_subnet.subnet2.id
}

# Subnet DB-1
output "subnet3" {
  description = "Subnet DB-1"
  value = aws_subnet.subnet3.id
}

# Subnet DB-2
output "subnet4" {
  description = "Subnet DB-2"
  value = aws_subnet.subnet4.id
}

# Web Network Security Group
output "nsg_web" {
  description = "Web Network Security Group"
  value = aws_security_group.ghost-web.id
}

# Database Network Security Group
output "db_web" {
  description = "Database Network Security Group"
  value = aws_security_group.ghost_db_sg.id
}

# Database Endpoint
output "database_endpoint" {
  description = "Database Endpoint"
  value = aws_rds_cluster.ghost_db.endpoint
}

# ALB DNS Name
output "alb_dns" {
  description = "ALB DNS"
  value = aws_lb.ghost-alb.dns_name
}

# Target Group ID
output "tg_id" {
  description = "Target Group ID"
  value = aws_lb_target_group.ghost-tg.id
}

# Launch Template ID
output "lt_id" {
  description = "Launch Template ID"
  value = aws_launch_template.ghost-launch-template.id
}

# ASG ID
output "asg_id" {
  description = "ASG ID"
  value = aws_autoscaling_group.ghost-asg.id
}

# Hosted Zone ID
output "zone_id" {
  description = "Hosted Zone ID"
  value = aws_route53_zone.www.id
}