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

output "lambda_function_name" {
  description = "Nome da função Lambda"
  value       = module.lambda.function_name
}

output "lambda_function_arn" {
  description = "ARN da função Lambda"
  value       = module.lambda.function_arn
}

output "lambda_invoke_arn" {
  description = "ARN de invocação da função Lambda"
  value       = module.lambda.function_invoke_arn
}

output "lambda_role_arn" {
  description = "ARN da IAM Role da Lambda"
  value       = module.lambda.function_role_arn
}

output "lambda_log_group" {
  description = "Nome do CloudWatch Log Group da Lambda"
  value       = module.lambda.log_group_name
}

output "api_gateway_id" {
  description = "ID da API Gateway"
  value       = module.apigateway.api_id
}

output "api_gateway_endpoint" {
  description = "URL base da API Gateway"
  value       = module.apigateway.api_endpoint
}

output "api_gateway_auth_endpoint" {
  description = "URL completa do endpoint /auth"
  value       = module.apigateway.auth_endpoint
}

output "api_gateway_fastfood_endpoint" {
  description = "URL base do endpoint /fastfood"
  value       = module.apigateway.fastfood_endpoint
}

output "api_gateway_stage" {
  description = "Stage da API Gateway"
  value       = module.apigateway.stage_name
}