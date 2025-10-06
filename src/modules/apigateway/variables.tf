variable "api_name" {
  description = "Nome da API Gateway"
  type        = string
  default     = "tcc-api"
}

variable "api_description" {
  description = "Descrição da API Gateway"
  type        = string
  default     = "API Gateway para TCC"
}

variable "stage_name" {
  description = "Nome do stage de deployment"
  type        = string
  default     = "prod"
}

variable "stage_description" {
  description = "Descrição do stage"
  type        = string
  default     = "Producao"
}

variable "lambda_function_name" {
  description = "Nome da função Lambda para integração"
  type        = string
}

variable "lambda_invoke_arn" {
  description = "ARN de invocação da função Lambda"
  type        = string
}

variable "cors_allow_origin" {
  description = "Valor do header Access-Control-Allow-Origin para CORS"
  type        = string
  default     = "'*'"
}

variable "cognito_user_pool_arn" {
  description = "ARN do Cognito User Pool para autenticação"
  type        = string
}

variable "tags" {
  description = "Tags para os recursos"
  type        = map(string)
  default     = {}
}