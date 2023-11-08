resource "aws_api_gateway_rest_api" "api" {
  name = "apigtwapp_resource"
}

resource "aws_api_gateway_resource" "test_path" {
  parent_id   = aws_api_gateway_rest_api.api.root_resource_id
  path_part   = "Events"
  rest_api_id = data.aws_api_gateway_rest_api.my_rest_api.id
  path        = "/test"
}

resource "aws_api_gateway_method" "test_method" {
  rest_api_id           = aws_api_gateway_rest_api.api.id
  resource_id             = aws_api_gateway_rest_api.api.test_path.id
  http_method           = "POST"
  authorization         = "NONE"
}

resource "aws_api_gateway_integration" "test_path_integration" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_rest_api.api.test_path.id
  http_method             = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.lambda_app.invoke_arn
  integration_http_method = "POST"
}