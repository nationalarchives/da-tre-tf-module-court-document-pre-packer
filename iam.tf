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
  name               = "${var.env}-${var.prefix}-forward-lambda-role"
  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role_policy.json
  permissions_boundary = var.tre_permission_boundary_arn
}

resource "aws_iam_role_policy_attachment" "tre_success_lambda_logs" {
  role       = aws_iam_role.tre_court_document_pre_packer_role.name
  policy_arn = "arn:aws:iam::aws:policy/AWSOpsWorksCloudWatchLogs"
}
