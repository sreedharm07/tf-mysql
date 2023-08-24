data "aws_ssm_parameter" "dbname" {
  name = "rds-dev-dbname"
}

data "aws_ssm_parameter" "username" {
  name = "rds-dev-username"
}

data "aws_ssm_parameter" "password" {
  name = "rds-dev-password"
}
