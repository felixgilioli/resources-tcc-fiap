output "rds_endpoint" {
  description = "Endpoint de conexão do RDS"
  value       = module.rds.db_endpoint
}

output "rds_address" {
  description = "Endereço do RDS"
  value       = module.rds.db_address
}

output "rds_port" {
  description = "Porta do RDS"
  value       = module.rds.db_port
}

output "rds_database_name" {
  description = "Nome do banco de dados"
  value       = module.rds.db_name
}

output "rds_username" {
  description = "Username do banco de dados"
  value       = module.rds.db_username
  sensitive   = true
}

output "vpc_id" {
  description = "ID da VPC"
  value       = module.networking.vpc_id
}

output "public_subnet_ids" {
  description = "IDs das subnets públicas"
  value       = module.networking.public_subnet_ids
}

output "rds_security_group_id" {
  description = "ID do Security Group do RDS"
  value       = module.networking.rds_security_group_id
}

output "connection_string" {
  description = "String de conexão PostgreSQL"
  value       = "postgresql://${module.rds.db_username}:${var.db_password}@${module.rds.db_endpoint}/${module.rds.db_name}"
  sensitive   = true
}

output "cognito_user_pool_id" {
  description = "ID do Cognito User Pool"
  value       = module.cognito.user_pool_id
}

output "cognito_user_pool_arn" {
  description = "ARN do Cognito User Pool"
  value       = module.cognito.user_pool_arn
}

output "cognito_user_pool_endpoint" {
  description = "Endpoint do Cognito User Pool"
  value       = module.cognito.user_pool_endpoint
}

output "cognito_app_client_id" {
  description = "ID do App Client do Cognito"
  value       = module.cognito.app_client_id
}