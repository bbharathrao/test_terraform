data "archive_file" "leads-handler" {
  type        = "zip"
  source_file = "../../modules/leads-process/leads-handler.py"
  output_path = "../../modules/leads-process/outputs/leads-handler.zip"
}

resource "aws_lambda_function" "lead_process_lambda" {
  filename      = "../../modules/leads-process/outputs/leads-handler.zip"
  function_name = "leads-handler"
  role          = "${aws_iam_role.lead_process_role.arn}"
  handler       = "leads-handler.lambda_handler"

  runtime = "python3.6"
}
