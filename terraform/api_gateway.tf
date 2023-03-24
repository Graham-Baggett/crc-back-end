resource "aws_api_gateway_rest_api" "crc_api_infra_api" {
  name        = "crc-api-infra"
  description = "API Gateway for the Visitor Count Lambda functions"
}

resource "aws_api_gateway_resource" "proxy" {
  rest_api_id = "${aws_api_gateway_rest_api.crc_api_infra_api.id}"
  parent_id   = "${aws_api_gateway_rest_api.crc_api_infra_api.root_resource_id}"
  path_part   = "{proxy+}"
}

resource "aws_api_gateway_method" "proxy" {
  rest_api_id   = "${aws_api_gateway_rest_api.crc_api_infra_api.id}"
  resource_id   = "${aws_api_gateway_resource.proxy.id}"
  http_method   = "ANY"
  authorization = "NONE"
}

resource "aws_api_gateway_method" "proxy_root" {
  rest_api_id   = "${aws_api_gateway_rest_api.crc_api_infra_api.id}"
  resource_id   = "${aws_api_gateway_rest_api.crc_api_infra_api.root_resource_id}"
  http_method   = "ANY"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "lambda_root" {
  rest_api_id = "${aws_api_gateway_rest_api.crc_api_infra_api.id}"
  resource_id = "${aws_api_gateway_method.proxy_root.resource_id}"
  http_method = "${aws_api_gateway_method.proxy_root.http_method}"

  integration_http_method = "GET"
  type                    = "AWS_PROXY"
  uri                     = "${aws_lambda_function.example.invoke_arn}"
}

resource "aws_api_gateway_deployment" "example" {
  depends_on = [
    "aws_api_gateway_integration.lambda",
    "aws_api_gateway_integration.lambda_root",
  ]

  rest_api_id = "${aws_api_gateway_rest_api.crc_api_infra_api.id}"
  stage_name  = "Prod"
}

output "base_url" {
  value = "${aws_api_gateway_deployment.crc_api_infra_api.invoke_url}"
}
