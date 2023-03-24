resource "aws_api_gateway_rest_api" "crc_api_infra_api" {
  name        = "crc-api-infra"
  description = "API Gateway for the Visitor Count Lambda functions"
}

resource "aws_api_gateway_resource" "prod" {
  rest_api_id = aws_api_gateway_rest_api.crc_api_infra_api.id
  parent_id   = aws_api_gateway_rest_api.crc_api_infra_api.root_resource_id
  path_part   = "Prod"
}

resource "aws_api_gateway_method" "get" {
  rest_api_id   = aws_api_gateway_rest_api.crc_api_infra_api.id
  resource_id   = aws_api_gateway_resource.prod.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "get" {
  rest_api_id = aws_api_gateway_rest_api.crc_api_infra_api.id
  resource_id = aws_api_gateway_resource.crc_api_infra_api.id
  http_method = aws_api_gateway_method.get.http_method

  integration_http_method = "GET"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.get_visitor_count_function.invoke_arn
}

resource "aws_api_gateway_deployment" "example" {
  depends_on = [
    "aws_api_gateway_integration.lambda",
    "aws_api_gateway_integration.lambda_root",
  ]

  rest_api_id = aws_api_gateway_rest_api.crc_api_infra_api.id
  stage_name  = "Prod"
}

output "base_url" {
  value = aws_api_gateway_deployment.crc_api_infra_api.invoke_url
}
