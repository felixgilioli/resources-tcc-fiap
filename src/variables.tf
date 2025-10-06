variable "region" {
  description = "Região da AWS"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Nome do projeto"
  type        = string
  default     = "fastfood"
}

variable "vpc_cidr" {
  description = "CIDR block da VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "availability_zones" {
  description = "Zonas de disponibilidade"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}

variable "public_subnet_cidrs" {
  description = "CIDRs das subnets públicas"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

# Variáveis do RDS
variable "db_name" {
  description = "Nome do banco de dados"
  type        = string
  default     = "fastfood"
}

variable "db_username" {
  description = "Username do banco de dados"
  type        = string
  default     = "root"
}

variable "db_password" {
  description = "Senha do banco de dados"
  type        = string
  sensitive   = true
  default     = "12345678" # ATENÇÃO: Em produção, usar AWS Secrets Manager
}

variable "instance_class" {
  description = "Classe da instância RDS"
  type        = string
  default     = "db.t3.micro"
}

variable "allocated_storage" {
  description = "Armazenamento inicial em GB"
  type        = number
  default     = 20
}

variable "max_allocated_storage" {
  description = "Armazenamento máximo em GB"
  type        = number
  default     = 20
}

variable "backup_retention_period" {
  description = "Período de retenção de backup em dias"
  type        = number
  default     = 1
}

variable "skip_final_snapshot" {
  description = "Pular snapshot final ao destruir"
  type        = bool
  default     = true # Em produção, definir como false
}

variable "publicly_accessible" {
  description = "Permitir acesso público ao RDS"
  type        = bool
  default     = true
}

variable "tags" {
  description = "Tags padrão para todos os recursos"
  type        = map(string)
  default = {
    Project     = "FastFood"
    Environment = "Development"
    ManagedBy   = "Terraform"
  }
}

variable "cognito_user_pool_name" {
  description = "Nome do Cognito User Pool"
  type        = string
  default     = "tcc-user-pool"
}

variable "cognito_app_client_name" {
  description = "Nome do App Client do Cognito"
  type        = string
  default     = "tcc-app-client"
}

variable "lambda_function_name" {
  description = "Nome da função Lambda"
  type        = string
  default     = "tcc-auth-lambda"
}

variable "lambda_runtime" {
  description = "Runtime da função Lambda"
  type        = string
  default     = "nodejs20.x"
}

variable "lambda_timeout" {
  description = "Timeout da função Lambda em segundos"
  type        = number
  default     = 10
}

variable "lambda_memory_size" {
  description = "Memória da função Lambda em MB"
  type        = number
  default     = 256
}

variable "lambda_log_retention_days" {
  description = "Dias de retenção dos logs da Lambda"
  type        = number
  default     = 7
}

variable "api_gateway_name" {
  description = "Nome da API Gateway"
  type        = string
  default     = "tcc-api"
}

variable "api_gateway_description" {
  description = "Descrição da API Gateway"
  type        = string
  default     = "API Gateway para TCC"
}

variable "api_gateway_stage_name" {
  description = "Nome do stage da API Gateway"
  type        = string
  default     = "prod"
}

variable "api_gateway_stage_description" {
  description = "Descrição do stage da API Gateway"
  type        = string
  default     = "Producao"
}

variable "api_gateway_cors_allow_origin" {
  description = "CORS Allow Origin"
  type        = string
  default     = "'*'"
}