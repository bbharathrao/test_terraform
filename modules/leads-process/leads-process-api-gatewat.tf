resource "aws_api_gateway_rest_api" "lead-process-api" {
  name = "lead-process-api"
  description = "This api will be used to push the leads to lambda (Lambda-process) it is created from terraform."
  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

resource "aws_api_gateway_resource" "lead-process-push-leads-resource" {
  rest_api_id = "${aws_api_gateway_rest_api.lead-process-api.id}"
  parent_id   = "${aws_api_gateway_rest_api.lead-process-api.root_resource_id}"
  path_part   = "push-leads"
}
plurroute
resource "aws_api_gateway_method" "lead-process-post-method" {
  rest_api_id   = "${aws_api_gateway_rest_api.lead-process-api.id}"
  resource_id   = "${aws_api_gateway_resource.lead-process-push-leads-resource.id}"
  http_method   = "POST"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "lead-process-gateway-lambda-integration" {
  rest_api_id             = "${aws_api_gateway_rest_api.lead-process-api.id}"
  resource_id             = "${aws_api_gateway_resource.lead-process-push-leads-resource.id}"
  http_method             = "${aws_api_gateway_method.lead-process-post-method.http_method}"
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = "${aws_lambda_function.lead_process_lambda.invoke_arn}"
}

resource "aws_lambda_permission" "allow_api" {
  statement_id  = "AllowAPIgatewayInvokation"
  action        = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.lead_process_lambda.function_name}"
  principal     = "apigateway.amazonaws.com"
}

