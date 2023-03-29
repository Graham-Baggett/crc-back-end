resource "aws_api_gateway_rest_api" "crc_api_infra_api" {
  name        = var.api_name
  description = "API Gateway for the Visitor Count Lambda functions"
}

resource "aws_api_gateway_resource" "get" {
  rest_api_id = aws_api_gateway_rest_api.crc_api_infra_api.id
  parent_id   = aws_api_gateway_rest_api.crc_api_infra_api.root_resource_id
  path_part   = var.get_path_part
}

resource "aws_api_gateway_resource" "put" {
  rest_api_id = aws_api_gateway_rest_api.crc_api_infra_api.id
  parent_id   = aws_api_gateway_rest_api.crc_api_infra_api.root_resource_id
  path_part   = var.put_path_part
}

resource "aws_api_gateway_method" "get" {
  rest_api_id   = aws_api_gateway_rest_api.crc_api_infra_api.id
  resource_id   = aws_api_gateway_resource.get.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_method" "put" {
  rest_api_id   = aws_api_gateway_rest_api.crc_api_infra_api.id
  resource_id   = aws_api_gateway_resource.put.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "apigw-integration-get" {
  rest_api_id = aws_api_gateway_rest_api.crc_api_infra_api.id
  resource_id = aws_api_gateway_resource.get.id
  http_method = aws_api_gateway_method.get.http_method

  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.get_visitor_count_function.invoke_arn
}

resource "aws_api_gateway_integration" "apigw-integration-put" {
  rest_api_id = aws_api_gateway_rest_api.crc_api_infra_api.id
  resource_id = aws_api_gateway_resource.put.id
  http_method = aws_api_gateway_method.put.http_method

  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.increment_visitor_count_function.invoke_arn
}

resource "aws_api_gateway_method_response" "get_method_response" {
  depends_on      = [aws_lambda_function.get_visitor_count_function, aws_api_gateway_method.get]
  rest_api_id     = aws_api_gateway_rest_api.crc_api_infra_api.id
  resource_id     = aws_api_gateway_rest_api.crc_api_infra_api.root_resource_id
  http_method     = aws_api_gateway_method.get.http_method
  status_code     = 200
  response_models = { "application/json" = "Empty" }
  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = true,
    "method.response.header.Access-Control-Allow-Methods" = true,
    "method.response.header.Access-Control-Allow-Origin"  = true,
  }
}

resource "aws_api_gateway_integration_response" "get_integration_response" {
  rest_api_id = aws_api_gateway_rest_api.crc_api_infra_api.id
  resource_id = aws_api_gateway_rest_api.crc_api_infra_api.root_resource_id
  http_method = aws_api_gateway_method.get.http_method
  status_code = "200"
  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = "'*'",
    "method.response.header.Access-Control-Allow-Methods" = "'POST,OPTIONS,GET,PUT,PATCH,DELETE'",
    "method.response.header.Access-Control-Allow-Origin"  = "'*'"
  }

  depends_on = [
    aws_lambda_function.get_visitor_count_function,
    aws_api_gateway_integration.apigw-integration-get,
    aws_api_gateway_method_response.get_method_response
  ]
}

resource "aws_api_gateway_method_response" "put_method_response" {
  depends_on      = ["aws_lambda_function.increment_visitor_count_function", "aws_api_gateway_method.put"]
  rest_api_id     = aws_api_gateway_rest_api.crc_api_infra_api.id
  resource_id     = aws_api_gateway_rest_api.crc_api_infra_api.root_resource_id
  http_method     = aws_api_gateway_method.put.http_method
  status_code     = 200
  response_models = { "application/json" = "Empty" }
  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = true,
    "method.response.header.Access-Control-Allow-Methods" = true,
    "method.response.header.Access-Control-Allow-Origin"  = true,
  }
}

resource "aws_api_gateway_integration_response" "put_integration_response" {
  rest_api_id = aws_api_gateway_rest_api.crc_api_infra_api.id
  resource_id = aws_api_gateway_rest_api.crc_api_infra_api.root_resource_id
  http_method = aws_api_gateway_method.put.http_method
  status_code = "200"
  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = "'*'",
    "method.response.header.Access-Control-Allow-Methods" = "'POST,OPTIONS,GET,PUT,PATCH,DELETE'",
    "method.response.header.Access-Control-Allow-Origin"  = "'*'"
  }

  depends_on = [
    aws_lambda_function.increment_visitor_count_function,
    aws_api_gateway_integration.apigw-integration-put,
    aws_api_gateway_method_response.put_method_response
  ]
}

resource "aws_api_gateway_deployment" "apigw-deployment" {
  depends_on = [
    aws_api_gateway_integration.apigw-integration-get,
    aws_api_gateway_integration.apigw-integration-put
  ]

  rest_api_id = aws_api_gateway_rest_api.crc_api_infra_api.id
  stage_name  = "Prod"
}

output "base_url" {
  value = aws_api_gateway_deployment.apigw-deployment.invoke_url
}
