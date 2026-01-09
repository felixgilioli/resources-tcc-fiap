output "docdb_endpoint" {
  description = "Endpoint do cluster DocumentDB"
  value       = aws_docdb_cluster.main.endpoint
}

output "docdb_port" {
  description = "Porta do cluster DocumentDB"
  value       = aws_docdb_cluster.main.port
}

