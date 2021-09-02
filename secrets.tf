data "aws_secretsmanager_secret_version" "creds" {
  secret_id = "aurora-serv1"
}

locals {
  db_creds = jsondecode(
    data.aws_secretsmanager_secret_version.creds.secret_string
  )
}