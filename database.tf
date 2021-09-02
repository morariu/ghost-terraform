resource "aws_rds_cluster" "ghost_db" {
  cluster_identifier      = "ghost-cluster"
  engine                  = "aurora-mysql"
  engine_version          = "5.7.mysql_aurora.2.07.1"
  database_name           = "ghost_db"
  master_username         = local.db_creds.username
  master_password         = local.db_creds.password
  engine_mode             = "serverless"
  vpc_security_group_ids  = [aws_security_group.ghost_db_sg.id]
  db_subnet_group_name    = aws_db_subnet_group.mysql_subnet.name
  skip_final_snapshot     = true
  backup_retention_period = 1
  apply_immediately       = true


  scaling_configuration {
    auto_pause               = true
    min_capacity             = 2
    seconds_until_auto_pause = 300
    timeout_action           = "ForceApplyCapacityChange"
  }
}

resource "aws_db_subnet_group" "mysql_subnet" {
  name       = "main"
  subnet_ids = [aws_subnet.subnet3.id, aws_subnet.subnet4.id]
}

resource "aws_security_group" "ghost_db_sg" {
  name        = "ghost_db_sg"
  description = "ghost_db_sg"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "TCP"
    security_groups = [aws_security_group.ghost-web.id]
  }

  egress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "TCP"
    security_groups = [aws_security_group.ghost-web.id]
  }

}