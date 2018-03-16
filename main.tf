# aws_api_gateway_integration

resource "aws_api_gateway_method" "this" {
  rest_api_id         = "${var.api_id}"
  resource_id         = "${var.endpoint_id}"

  http_method         = "OPTIONS"
  authorization       = "NONE"
}

resource "aws_api_gateway_integration" "this" {
  rest_api_id         = "${var.api_id}"
  resource_id         = "${var.endpoint_id}"

  http_method         = "${aws_api_gateway_method.this.http_method}"
  type                = "MOCK"

  request_templates   = { 
    "application/json" = <<PARAMS
{ "statusCode": 200 }
PARAMS
  }
}

resource "aws_api_gateway_integration_response" "response" {
  depends_on          = ["aws_api_gateway_integration.this"]

  rest_api_id         = "${var.api_id}"
  resource_id         = "${var.endpoint_id}"
  http_method         = "${aws_api_gateway_method.this.http_method}"

  status_code         = "200"
  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers"   = "'${var.all_headers != false ? "*" : join(",", var.headers)}'"
    "method.response.header.Access-Control-Allow-Methods"   = "'${var.all_methods != false ? "*" : upper(join(",", var.methods))}'"
    "method.response.header.Access-Control-Allow-Origin"    = "'${var.all_origins != false ? "*" : join(",", var.origins)}'"
  }
}

resource "aws_api_gateway_method_response" "response" {
  depends_on          = ["aws_api_gateway_method.this", "aws_api_gateway_integration.this"]

  rest_api_id         = "${var.api_id}"
  resource_id         = "${var.endpoint_id}"
  http_method         = "${aws_api_gateway_method.this.http_method}"

  status_code         = "200"

  response_models = { "application/json" = "Empty" }
  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = true,
    "method.response.header.Access-Control-Allow-Methods" = true,
    "method.response.header.Access-Control-Allow-Origin"  = true
  }  
}
