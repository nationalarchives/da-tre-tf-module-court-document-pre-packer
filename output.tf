output "court_document_pre_packer_lambda_arn" {
  value       = aws_lambda_function.court_document_pre_packer.arn
  description = "Court Document Pre Packer Lambda ARN"
}

output "court_document_pre_packer_lambda_role_arn" {
  value       = aws_lambda_function.court_document_pre_packer.role
  description = "Court Document Pre Packer Lambda Role ARN"
}
