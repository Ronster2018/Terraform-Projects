
# Create REST api Gateway
resource "aws_api_gateway_rest_api" "rest_api_gw" {
  name        = "Serverless"
  description = "Serverless Application using Terraform"
}

resource "aws_api_gateway_resource" "proxy" {
  rest_api_id = aws_api_gateway_rest_api.rest_api_gw.id
  parent_id   = aws_api_gateway_rest_api.rest_api_gw.root_resource_id
  # "{proxy+}": This resource will match any request path. all incoming requests will match this resource
  path_part = "{proxy+}"
}

resource "aws_api_gateway_method" "proxy" {
  rest_api_id   = aws_api_gateway_rest_api.rest_api_gw.id
  resource_id   = aws_api_gateway_resource.proxy.id
  http_method   = "ANY"
  authorization = "NONE"
}

# API Gateway - Lambda Connection
resource "aws_api_gateway_integration" "lambda" {
  rest_api_id             = aws_api_gateway_rest_api.rest_api_gw.id
  resource_id             = aws_api_gateway_method.proxy.resource_id
  http_method             = aws_api_gateway_method.proxy.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  # With AWS_PROXY, it causes API gateway to call into the API of another AWS service
  uri = aws_lambda_function.lambda_function.invoke_arn
}

# The proxy resource cannot match an empty path at the root of the API.
# To handle that, a similar configuration must be applied to the root resource that is built in to the REST API object
resource "aws_api_gateway_method" "proxy_root" {
  rest_api_id   = aws_api_gateway_rest_api.rest_api_gw.id
  resource_id   = aws_api_gateway_rest_api.rest_api_gw.root_resource_id
  http_method   = "ANY"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "lambda_root" {
  rest_api_id             = aws_api_gateway_rest_api.rest_api_gw.id
  resource_id             = aws_api_gateway_method.proxy_root.resource_id
  http_method             = aws_api_gateway_method.proxy_root.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY" # With AWS_PROXY, it causes API gateway to call into the API of another AWS service
  uri                     = aws_lambda_function.lambda_function.invoke_arn
}


# Deploy API Gateway
resource "aws_api_gateway_deployment" "api_deploy" {
  depends_on = [
    aws_api_gateway_integration.lambda,
    aws_api_gateway_integration.lambda_root
  ]

  rest_api_id = aws_api_gateway_rest_api.rest_api_gw.id
  stage_name  = "Test"
}
