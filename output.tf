output "tre_court_document_pre_packer_lambda_arn" {
  value       = aws_lambda_function.tre_court_document_pre_packer.arn
  description = "TRE Court Document Pre Packer Lambda ARN"
}

output "tre_court_document_pre_packer_lambda_role_arn" {
  value       = aws_lambda_function.tre_court_document_pre_packer.role
  description = "TRE Court Document Pre Packer Lambda Role ARN"
}
