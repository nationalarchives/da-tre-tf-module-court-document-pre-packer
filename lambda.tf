# TRE-Forward Lambda
resource "aws_lambda_function" "tre_court_document_pre_packer" {
  image_uri     = "${var.ecr_uri_host}/${var.ecr_uri_repo_prefix}${var.prefix}-mk-junk-example:${var.court_document_pre_pack_image_versions.tre_court_document_pre_pack}"
  package_type  = "Image"
  function_name = "${var.env}-${var.prefix}-court-document-pre-packer"
  role          = aws_iam_role.tre_court_document_pre_packer_role.arn
  timeout       = 30
  memory_size   = 1024
  environment {
    variables = {
      "TRE_INTERNAL_TOPIC_ARN" = var.tre_internal_topic_arn
    }
  }
  tracing_config {
    mode = "Active"
  }

  tags = {
    "ApplicationType" = "Scala"
  }
}

resource "aws_lambda_function_event_invoke_config" "pre_packer_success_failure_destinations" {
  function_name = aws_lambda_function.tre_court_document_pre_packer.function_name
  destination_config {
    on_success {
      destination = var.success_handler_lambda_arn
    }
    on_failure {
      destination = var.success_handler_lambda_arn
    }
  }
}

resource "aws_lambda_event_source_mapping" "tre_internal_sns" {
  batch_size                         = 1
  function_name                      = aws_lambda_function.tre_court_document_pre_packer.function_name
  event_source_arn                   = var.tre_internal_topic_arn
}
