# Lambda Roles & Policies
data "aws_iam_policy_document" "lambda_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "tre_court_document_pre_packer_role" {
  name               = "${var.env}-${var.prefix}-court-document-pre-packer-lambda-role"
  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role_policy.json
  permissions_boundary = var.tre_permission_boundary_arn
}

resource "aws_iam_role_policy_attachment" "tre_success_lambda_logs" {
  role       = aws_iam_role.tre_court_document_pre_packer_role.name
  policy_arn = "arn:aws:iam::aws:policy/AWSOpsWorksCloudWatchLogs"
}

data "aws_iam_policy_document" "pre_packer_lambda_invoke_policy_data" {
  statement {
    sid     = "InvokeLambdaPolicy"
    effect  = "Allow"
    actions = ["lambda:InvokeFunction"]
    resources = [
      var.success_handler_lambda_arn
    ]
  }
}

resource "aws_iam_policy" "pre_packer_lambda_invoke_policy" {
  name        = "${var.env}-${var.prefix}-pre-packer-lambda-invoke"
  description = "The policy for pre packer lambda to invoke success lambda"
  policy      = data.aws_iam_policy_document.pre_packer_lambda_invoke_policy_data.json
}
