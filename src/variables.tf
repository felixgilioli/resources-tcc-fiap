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