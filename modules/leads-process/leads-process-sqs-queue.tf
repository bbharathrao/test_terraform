resource "aws_sqs_queue" "leads_process_queue" {
  name                      = "leads-process-queue"
  visibility_timeout_seconds = 10
  max_message_size          = 262144
  message_retention_seconds = 345600
}

resource "aws_lambda_event_source_mapping" "lead-process-sqs-trigger" {
  event_source_arn = "${aws_sqs_queue.leads_process_queue.arn}"
  function_name    = "${aws_lambda_function.lead_process_lambda.arn}"
}