resource "aws_lambda_function" "get_visitor_count_function" {
  function_name = "get-visitor-count-function"
  role          = aws_iam_role.get_visitor_count_function_role.arn
  runtime       = "python3.8"
  timeout       = 3
  filename      = "python/src/return_count/lambda_get_visitor_count.py"

  environment {
    variables = {
      TABLE_NAME = aws_dynamodb_table.visitor_count_table.name
    }
  }

  handler = "lambda_get_visitor_count.lambda_handler"

  event_source_mapping {
    event_source_arn  = aws_dynamodb_table.visitor_count_table.arn
    batch_size        = 10
    starting_position = "LATEST"
  }

  depends_on = [
    aws_dynamodb_table.visitor_count_table,
  ]
}

resource "aws_lambda_function" "increment_visitor_count_function" {
  function_name = "increment-visitor-count-function"
  role          = aws_iam_role.increment_visitor_count_function_role.arn
  runtime       = "python3.8"
  timeout       = 3
  filename      = "python/src/increment_count/lambda_increment_visitor_count.py"

  environment {
    variables = {
      TABLE_NAME = aws_dynamodb_table.visitor_count_table.name
    }
  }

  handler = "lambda_increment_visitor_count.lambda_handler"

  event_source_mapping {
    event_source_arn = aws_dynamodb_table.visitor_count_table.arn
    batch_size       = 10
    starting_position = "LATEST"
  }

  depends_on = [
    aws_dynamodb_table.visitor_count_table,
  ]
}

resource "aws_iam_role" "get_visitor_count_function_role" {
  name = "get-visitor-count-function-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })

  policy {
    name = "dynamodb-read-policy"
    policy = jsonencode({
      Version = "2012-10-17"
      Statement = [
        {
          Effect   = "Allow"
          Action   = "dynamodb:GetItem"
          Resource = aws_dynamodb_table.visitor_count_table.arn
        }
      ]
    })
  }
}

resource "aws_iam_role" "increment_visitor_count_function_role" {
  name = "increment-visitor-count-function-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })

  policy {
    name = "dynamodb-write-policy"
    policy = jsonencode({
      Version = "2012-10-17"
      Statement = [
        {
          Effect   = "Allow"
          Action   = "dynamodb:PutItem"
          Resource = aws_dynamodb_table.visitor_count_table.arn
        }
      ]
    })
  }
}

resource "aws_lambda_permission" "apigw_get_visitor_count" {
  statement_id  = "AllowAPIGatewayInvokeGetVisitorCount"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.get_visitor_count_function.function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "arn:aws:execute-api:${var.region}:${var.account_id}:${aws_api_gateway_rest_api.crc_api_infra_api.id}/*/GET/${aws_api_gateway_resource.get.path_part}"
}

resource "aws_lambda_permission" "apigw_increment_visitor_count" {
  statement_id  = "AllowAPIGatewayInvokeIncrementVisitorCount"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.increment_visitor_count_function.function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "arn:aws:execute-api:${var.region}:${var.account_id}:${aws_api_gateway_rest_api.crc_api_infra_api.id}/*/GET/${aws_api_gateway_resource.put.path_part}"
}
