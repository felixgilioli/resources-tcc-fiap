variable "role_name" {
  description = "Nome da IAM Role"
  type        = string
  default     = "fast-food-service-role"
}

variable "cognito_user_pool_arn" {
  description = "ARN do Cognito User Pool"
  type        = string
}

variable "tags" {
  description = "Tags para os recursos"
  type        = map(string)
  default     = {}
}