variable "function_name" {
  description = "Nome da função Lambda"
  type        = string
  default     = "tcc-auth-lambda"
}

variable "runtime" {
  description = "Runtime da função Lambda"
  type        = string
  default     = "nodejs20.x"
}

variable "timeout" {
  description = "Timeout da função em segundos"
  type        = number
  default     = 10
}

variable "memory_size" {
  description = "Memória alocada para a função em MB"
  type        = number
  default     = 256
}

variable "log_retention_days" {
  description = "Dias de retenção dos logs no CloudWatch"
  type        = number
  default     = 7
}

variable "cognito_user_pool_id" {
  description = "ID do Cognito User Pool"
  type        = string
}

variable "cognito_user_pool_arn" {
  description = "ARN do Cognito User Pool"
  type        = string
}

variable "cognito_client_id" {
  description = "ID do App Client do Cognito"
  type        = string
}

variable "tags" {
  description = "Tags para os recursos"
  type        = map(string)
  default     = {}
}