variable "vpc_id" {
  description = "ID da VPC"
  type        = string
}

variable "subnet_ids" {
  description = "IDs das subnets para o DocumentDB subnet group"
  type        = list(string)
}

variable "security_group_ids" {
  description = "IDs dos security groups"
  type        = list(string)
}

variable "db_username" {
  description = "Username do cluster DocumentDB"
  type        = string
}

variable "db_password" {
  description = "Senha do cluster DocumentDB"
  type        = string
  sensitive   = true
}

variable "instance_class" {
  description = "Classe das instâncias do DocumentDB"
  type        = string
  default     = "db.t3.medium"
}

variable "cluster_identifier" {
  description = "Identificador do cluster DocumentDB"
  type        = string
  default     = "tcc-pedido-docdb"
}

variable "engine_version" {
  description = "Versão do engine DocumentDB"
  type        = string
  default     = "5.0.0"
}

variable "tags" {
  description = "Tags para os recursos"
  type        = map(string)
  default     = {}
}

