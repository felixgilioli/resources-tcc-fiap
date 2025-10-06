variable "user_pool_name" {
  description = "Nome do Cognito User Pool"
  type        = string
  default     = "tcc-user-pool"
}

variable "app_client_name" {
  description = "Nome do App Client"
  type        = string
  default     = "tcc-app-client"
}

variable "tags" {
  description = "Tags para os recursos"
  type        = map(string)
  default     = {}
}