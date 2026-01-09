resource "aws_docdb_subnet_group" "main" {
  name       = "tcc-pedido-docdb-subnet-group"
  subnet_ids = var.subnet_ids

  tags = merge(
    var.tags,
    {
      Name = "tcc-pedido-docdb-subnet-group"
    }
  )
}

resource "aws_docdb_cluster" "main" {
  cluster_identifier = var.cluster_identifier
  engine             = "docdb"
  engine_version     = var.engine_version

  master_username = var.db_username
  master_password = var.db_password

  db_subnet_group_name   = aws_docdb_subnet_group.main.name
  vpc_security_group_ids = var.security_group_ids

  backup_retention_period = 1
  skip_final_snapshot     = true

  apply_immediately = true

  tags = merge(
    var.tags,
    {
      Name = "tcc-pedido-docdb-cluster"
    }
  )
}

resource "aws_docdb_cluster_instance" "main" {
  count              = 1
  identifier         = "${var.cluster_identifier}-instance-${count.index}"
  cluster_identifier = aws_docdb_cluster.main.id
  instance_class     = var.instance_class

  tags = merge(
    var.tags,
    {
      Name = "tcc-pedido-docdb-instance-${count.index}"
    }
  )
}
