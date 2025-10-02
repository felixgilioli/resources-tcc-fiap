output "function_name" {
  description = "Nome da função Lambda"
  value       = aws_lambda_function.main.function_name
}

output "function_arn" {
  description = "ARN da função Lambda"
  value       = aws_lambda_function.main.arn
}

output "function_invoke_arn" {
  description = "ARN de invocação da função Lambda (para API Gateway)"
  value       = aws_lambda_function.main.invoke_arn
}

output "function_role_arn" {
  description = "ARN da IAM Role da função Lambda"
  value       = aws_iam_role.lambda_role.arn
}

output "function_role_name" {
  description = "Nome da IAM Role da função Lambda"
  value       = aws_iam_role.lambda_role.name
}

output "log_group_name" {
  description = "Nome do CloudWatch Log Group"
  value       = aws_cloudwatch_log_group.lambda_logs.name
}