resource "aws_db_subnet_group" "main" {
  name       = "${local.name_pre}-mysql-subnet"
  subnet_ids = var.subnets_ids
  tags = merge(local.tags,{Name="${local.name_pre}-mysql-subnet"})
}


resource "aws_security_group" "main" {
  name        =  "${local.name_pre}-mysqlsg"
  description = "${local.name_pre}-mysql-sg"
  vpc_id      = var.vpc_id
  tags = merge(local.tags,{Name= "${local.name_pre}-mysql-sg"})

  ingress {
    description      = "rds"
    from_port        = var.sg_port
    to_port          = var.sg_port
    protocol         = "tcp"
    cidr_blocks      = var.sg-ingress-cidr
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

resource "aws_db_parameter_group" "main" {
  name   = "rds-pg"
  family = var.family
}

resource "aws_rds_cluster" "main" {
  cluster_identifier               = "${local.name_pre}-cluster"
  db_subnet_group_name             = aws_db_subnet_group.main.name
  database_name                    = data.aws_ssm_parameter.dbname.name
  master_username                  = data.aws_ssm_parameter.username.name
  master_password                  = data.aws_ssm_parameter.password.name
  backup_retention_period          = var.backup_retention_period
  preferred_backup_window          = var.preferred_backup_window
  vpc_security_group_ids           = [aws_security_group.main.id]
  db_instance_parameter_group_name = aws_db_parameter_group.main.name
  engine_version                   = var.engine_version
  engine                           = var.engine
  skip_final_snapshot = var.skip_final_snapshot

  tags = merge(local.tags,{Name="${local.name_pre}-mysql-cluster"})
}

