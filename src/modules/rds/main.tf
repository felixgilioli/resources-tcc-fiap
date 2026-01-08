# DB Subnet Group
resource "aws_db_subnet_group" "main" {
  name       = "fastfood-db-subnet-group"
  subnet_ids = var.subnet_ids

  tags = merge(
    var.tags,
    {
      Name = "fastfood-db-subnet-group"
    }
  )
}

# Instância do RDS principal
resource "aws_db_instance" "main" {
  identifier            = "fastfood-rds"
  engine                = "postgres"
  engine_version        = "17.4"
  instance_class        = var.instance_class
  allocated_storage     = var.allocated_storage
  max_allocated_storage = var.max_allocated_storage

  db_name  = var.db_name
  username = var.db_username
  password = var.db_password
  port     = 5432

  vpc_security_group_ids = var.security_group_ids
  db_subnet_group_name   = aws_db_subnet_group.main.name

  backup_retention_period = var.backup_retention_period
  skip_final_snapshot     = var.skip_final_snapshot
  final_snapshot_identifier = var.skip_final_snapshot ? null : "fastfood-rds-final-snapshot-${formatdate("YYYY-MM-DD-hhmm", timestamp())}"

  publicly_accessible = var.publicly_accessible
  storage_encrypted   = true
  storage_type        = "gp3"
  multi_az            = false  # Para dev/teste, usar false para economizar custos

  # Performance Insights
  enabled_cloudwatch_logs_exports = ["postgresql", "upgrade"]

  # Maintenance
  auto_minor_version_upgrade = true
  maintenance_window         = "sun:03:00-sun:04:00"
  backup_window             = "02:00-03:00"

  # Deletion protection
  deletion_protection = false # Em produção, definir como true

  tags = merge(
    var.tags,
    {
      Name = "fastfood-postgres"
    }
  )
}

# Instância do RDS de pagamentos
resource "aws_db_instance" "pagamento" {
  identifier            = "pagamento-rds"
  engine                = aws_db_instance.main.engine
  engine_version        = aws_db_instance.main.engine_version
  instance_class        = aws_db_instance.main.instance_class
  allocated_storage     = aws_db_instance.main.allocated_storage
  max_allocated_storage = aws_db_instance.main.max_allocated_storage

  db_name  = var.db_name
  username = var.db_username
  password = var.db_password
  port     = aws_db_instance.main.port

  vpc_security_group_ids = var.security_group_ids
  db_subnet_group_name   = aws_db_subnet_group.main.name

  backup_retention_period  = aws_db_instance.main.backup_retention_period
  skip_final_snapshot      = aws_db_instance.main.skip_final_snapshot
  final_snapshot_identifier = var.skip_final_snapshot ? null : "pagamento-rds-final-snapshot-${formatdate("YYYY-MM-DD-hhmm", timestamp())}"

  publicly_accessible = aws_db_instance.main.publicly_accessible
  storage_encrypted   = aws_db_instance.main.storage_encrypted
  storage_type        = aws_db_instance.main.storage_type
  multi_az            = aws_db_instance.main.multi_az

  enabled_cloudwatch_logs_exports = aws_db_instance.main.enabled_cloudwatch_logs_exports

  auto_minor_version_upgrade = aws_db_instance.main.auto_minor_version_upgrade
  maintenance_window         = aws_db_instance.main.maintenance_window
  backup_window              = aws_db_instance.main.backup_window

  deletion_protection = aws_db_instance.main.deletion_protection

  tags = merge(
    var.tags,
    {
      Name = "pagamento-postgres"
    }
  )
}
