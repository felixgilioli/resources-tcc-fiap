output "db_instance_id" {
  description = "ID da instância RDS"
  value       = aws_db_instance.main.id
}

output "db_endpoint" {
  description = "Endpoint de conexão do RDS"
  value       = aws_db_instance.main.endpoint
}

output "db_address" {
  description = "Endereço do RDS"
  value       = aws_db_instance.main.address
}

output "db_port" {
  description = "Porta do RDS"
  value       = aws_db_instance.main.port
}

output "db_name" {
  description = "Nome do banco de dados"
  value       = aws_db_instance.main.db_name
}

output "db_username" {
  description = "Username do banco de dados"
  value       = aws_db_instance.main.username
  sensitive   = true
}

output "db_arn" {
  description = "ARN da instância RDS"
  value       = aws_db_instance.main.arn
}

output "db_resource_id" {
  description = "Resource ID da instância RDS"
  value       = aws_db_instance.main.resource_id
}