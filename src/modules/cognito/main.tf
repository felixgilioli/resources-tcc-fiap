# Cognito User Pool
resource "aws_cognito_user_pool" "main" {
  name = var.user_pool_name

  username_configuration {
    case_sensitive = false
  }

  # Política de senha
  password_policy {
    minimum_length    = 11
    require_uppercase = false
    require_lowercase = false
    require_numbers   = true
    require_symbols   = false
  }

  # Schema customizado para CPF
  schema {
    name                = "cpf"
    attribute_data_type = "String"
    mutable             = false

    string_attribute_constraints {
      min_length = 11
      max_length = 11
    }
  }

  # Atributos padrão
  schema {
    name                = "email"
    attribute_data_type = "String"
    required            = false
    mutable             = true
  }

  # Auto-verificação desabilitada
  auto_verified_attributes = []

  tags = var.tags
}

# Cognito User Pool Client
resource "aws_cognito_user_pool_client" "main" {
  name         = var.app_client_name
  user_pool_id = aws_cognito_user_pool.main.id

  generate_secret = false

  # Fluxos de autenticação
  explicit_auth_flows = [
    "ALLOW_ADMIN_USER_PASSWORD_AUTH",
    "ALLOW_REFRESH_TOKEN_AUTH"
  ]

  # Token validity (opcional)
  refresh_token_validity = 30
  access_token_validity  = 60
  id_token_validity      = 60

  token_validity_units {
    refresh_token = "days"
    access_token  = "minutes"
    id_token      = "minutes"
  }
}