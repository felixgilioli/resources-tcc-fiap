# Data source para obter o Account ID
data "aws_caller_identity" "current" {}

# API Gateway REST API
resource "aws_api_gateway_rest_api" "main" {
  name        = var.api_name
  description = var.api_description

  endpoint_configuration {
    types = ["REGIONAL"]
  }

  tags = var.tags
}

# Resource /auth
resource "aws_api_gateway_resource" "auth" {
  rest_api_id = aws_api_gateway_rest_api.main.id
  parent_id   = aws_api_gateway_rest_api.main.root_resource_id
  path_part   = "auth"
}

# Método POST em /auth
resource "aws_api_gateway_method" "auth_post" {
  rest_api_id   = aws_api_gateway_rest_api.main.id
  resource_id   = aws_api_gateway_resource.auth.id
  http_method   = "POST"
  authorization = "NONE"
}

# Integração POST com Lambda (AWS_PROXY)
resource "aws_api_gateway_integration" "auth_post_lambda" {
  rest_api_id             = aws_api_gateway_rest_api.main.id
  resource_id             = aws_api_gateway_resource.auth.id
  http_method             = aws_api_gateway_method.auth_post.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = var.lambda_invoke_arn
}

# Método OPTIONS em /auth (para CORS)
resource "aws_api_gateway_method" "auth_options" {
  rest_api_id   = aws_api_gateway_rest_api.main.id
  resource_id   = aws_api_gateway_resource.auth.id
  http_method   = "OPTIONS"
  authorization = "NONE"
}

# Integração OPTIONS (MOCK para CORS)
resource "aws_api_gateway_integration" "auth_options_mock" {
  rest_api_id = aws_api_gateway_rest_api.main.id
  resource_id = aws_api_gateway_resource.auth.id
  http_method = aws_api_gateway_method.auth_options.http_method
  type        = "MOCK"

  request_templates = {
    "application/json" = jsonencode({
      statusCode = 200
    })
  }
}

# Resposta do método OPTIONS
resource "aws_api_gateway_method_response" "auth_options_200" {
  rest_api_id = aws_api_gateway_rest_api.main.id
  resource_id = aws_api_gateway_resource.auth.id
  http_method = aws_api_gateway_method.auth_options.http_method
  status_code = "200"

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = true
    "method.response.header.Access-Control-Allow-Methods" = true
    "method.response.header.Access-Control-Allow-Origin"  = true
  }

  response_models = {
    "application/json" = "Empty"
  }
}

# Resposta da integração OPTIONS (CORS headers)
resource "aws_api_gateway_integration_response" "auth_options_integration_response" {
  rest_api_id = aws_api_gateway_rest_api.main.id
  resource_id = aws_api_gateway_resource.auth.id
  http_method = aws_api_gateway_method.auth_options.http_method
  status_code = aws_api_gateway_method_response.auth_options_200.status_code

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,Authorization'"
    "method.response.header.Access-Control-Allow-Methods" = "'POST,OPTIONS'"
    "method.response.header.Access-Control-Allow-Origin"  = var.cors_allow_origin
  }

  depends_on = [
    aws_api_gateway_integration.auth_options_mock
  ]
}

# Permissão para API Gateway invocar a Lambda
resource "aws_lambda_permission" "api_gateway_invoke" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = var.lambda_function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.main.execution_arn}/*/*"
}

# ========================================
# Rota /fastfood/* - Proxy para EKS
# ========================================

# Resource /fastfood
resource "aws_api_gateway_resource" "fastfood" {
  rest_api_id = aws_api_gateway_rest_api.main.id
  parent_id   = aws_api_gateway_rest_api.main.root_resource_id
  path_part   = "fastfood"
}

# Resource proxy {proxy+} para capturar qualquer path após /fastfood/
resource "aws_api_gateway_resource" "fastfood_proxy" {
  rest_api_id = aws_api_gateway_rest_api.main.id
  parent_id   = aws_api_gateway_resource.fastfood.id
  path_part   = "{proxy+}"
}

# Método ANY em /fastfood/{proxy+} (aceita qualquer método HTTP)
resource "aws_api_gateway_method" "fastfood_proxy_any" {
  rest_api_id   = aws_api_gateway_rest_api.main.id
  resource_id   = aws_api_gateway_resource.fastfood_proxy.id
  http_method   = "ANY"
  authorization = "NONE"

  request_parameters = {
    "method.request.path.proxy" = true
  }
}

# Integração HTTP_PROXY para /fastfood/{proxy+}
resource "aws_api_gateway_integration" "fastfood_proxy_http" {
  rest_api_id             = aws_api_gateway_rest_api.main.id
  resource_id             = aws_api_gateway_resource.fastfood_proxy.id
  http_method             = aws_api_gateway_method.fastfood_proxy_any.http_method
  type                    = "HTTP_PROXY"
  integration_http_method = "ANY"
  uri                     = "http://af7be7361cb0e4156882f52c80264048-5ec5431c43bfb41b.elb.us-east-1.amazonaws.com/{proxy}"

  request_parameters = {
    "integration.request.path.proxy" = "method.request.path.proxy"
  }

  cache_key_parameters = ["method.request.path.proxy"]
}

# Método OPTIONS em /fastfood/{proxy+} (para CORS)
resource "aws_api_gateway_method" "fastfood_proxy_options" {
  rest_api_id   = aws_api_gateway_rest_api.main.id
  resource_id   = aws_api_gateway_resource.fastfood_proxy.id
  http_method   = "OPTIONS"
  authorization = "NONE"
}

# Integração MOCK para OPTIONS em /fastfood/{proxy+}
resource "aws_api_gateway_integration" "fastfood_proxy_options_mock" {
  rest_api_id = aws_api_gateway_rest_api.main.id
  resource_id = aws_api_gateway_resource.fastfood_proxy.id
  http_method = aws_api_gateway_method.fastfood_proxy_options.http_method
  type        = "MOCK"

  request_templates = {
    "application/json" = jsonencode({
      statusCode = 200
    })
  }
}

# Resposta do método OPTIONS em /fastfood/{proxy+}
resource "aws_api_gateway_method_response" "fastfood_proxy_options_200" {
  rest_api_id = aws_api_gateway_rest_api.main.id
  resource_id = aws_api_gateway_resource.fastfood_proxy.id
  http_method = aws_api_gateway_method.fastfood_proxy_options.http_method
  status_code = "200"

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = true
    "method.response.header.Access-Control-Allow-Methods" = true
    "method.response.header.Access-Control-Allow-Origin"  = true
  }

  response_models = {
    "application/json" = "Empty"
  }
}

# Resposta da integração OPTIONS em /fastfood/{proxy+}
resource "aws_api_gateway_integration_response" "fastfood_proxy_options_integration_response" {
  rest_api_id = aws_api_gateway_rest_api.main.id
  resource_id = aws_api_gateway_resource.fastfood_proxy.id
  http_method = aws_api_gateway_method.fastfood_proxy_options.http_method
  status_code = aws_api_gateway_method_response.fastfood_proxy_options_200.status_code

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,Authorization,X-Amz-Date,X-Api-Key,X-Amz-Security-Token'"
    "method.response.header.Access-Control-Allow-Methods" = "'GET,POST,PUT,DELETE,PATCH,OPTIONS'"
    "method.response.header.Access-Control-Allow-Origin"  = var.cors_allow_origin
  }

  depends_on = [
    aws_api_gateway_integration.fastfood_proxy_options_mock
  ]
}

# Deployment
resource "aws_api_gateway_deployment" "main" {
  rest_api_id = aws_api_gateway_rest_api.main.id

  triggers = {
    redeployment = sha1(jsonencode([
      aws_api_gateway_resource.auth.id,
      aws_api_gateway_method.auth_post.id,
      aws_api_gateway_integration.auth_post_lambda.id,
      aws_api_gateway_method.auth_options.id,
      aws_api_gateway_integration.auth_options_mock.id,
      aws_api_gateway_resource.fastfood.id,
      aws_api_gateway_resource.fastfood_proxy.id,
      aws_api_gateway_method.fastfood_proxy_any.id,
      aws_api_gateway_integration.fastfood_proxy_http.id,
      aws_api_gateway_method.fastfood_proxy_options.id,
      aws_api_gateway_integration.fastfood_proxy_options_mock.id,
    ]))
  }

  lifecycle {
    create_before_destroy = true
  }

  depends_on = [
    aws_api_gateway_integration.auth_post_lambda,
    aws_api_gateway_integration.auth_options_mock,
    aws_api_gateway_integration_response.auth_options_integration_response,
    aws_api_gateway_integration.fastfood_proxy_http,
    aws_api_gateway_integration.fastfood_proxy_options_mock,
    aws_api_gateway_integration_response.fastfood_proxy_options_integration_response
  ]
}

# Stage
resource "aws_api_gateway_stage" "main" {
  deployment_id = aws_api_gateway_deployment.main.id
  rest_api_id   = aws_api_gateway_rest_api.main.id
  stage_name    = var.stage_name
  description   = var.stage_description

  tags = var.tags
}