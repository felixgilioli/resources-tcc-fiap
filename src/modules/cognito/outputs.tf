output "user_pool_id" {
  description = "ID do User Pool"
  value       = aws_cognito_user_pool.main.id
}

output "user_pool_arn" {
  description = "ARN do User Pool"
  value       = aws_cognito_user_pool.main.arn
}

output "user_pool_endpoint" {
  description = "Endpoint do User Pool"
  value       = aws_cognito_user_pool.main.endpoint
}

output "app_client_id" {
  description = "ID do App Client"
  value       = aws_cognito_user_pool_client.main.id
}

output "app_client_name" {
  description = "Nome do App Client"
  value       = aws_cognito_user_pool_client.main.name
}