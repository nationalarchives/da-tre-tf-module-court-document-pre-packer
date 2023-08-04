# Court Document Pre Packer Lambda
resource "aws_lambda_function" "court_document_pre_packer" {
  image_uri     = "${var.ecr_uri_host}/${var.ecr_uri_repo_prefix}da-tre-fn-court-document-pre-packer:${var.court_document_pre_pack_image_versions.tre_court_document_pre_pack}"
  package_type  = "Image"
  function_name = "${var.env}-${var.prefix}-court-document-pre-packer"
  role          = aws_iam_role.court_document_pre_packer_role.arn
  timeout       = 30
  memory_size   = 1024

  tracing_config {
    mode = "Active"
  }

  tags = {
    "ApplicationType" = "Scala"
  }
}

resource "aws_lambda_permission" "court_document_pre_packer_permission" {
  statement_id  = "AllowExecutionFromSNS"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.court_document_pre_packer.function_name
  principal     = "sns.amazonaws.com"
  source_arn    = var.tre_internal_topic_arn
}

resource "aws_lambda_function_event_invoke_config" "pre_packer_success_failure_destinations" {
  function_name = aws_lambda_function.court_document_pre_packer.function_name
  destination_config {
    on_success {
      destination = var.success_destination_lambda_arn
    }
    on_failure {
      destination = var.failure_destination_lambda_arn
    }
  }
}
