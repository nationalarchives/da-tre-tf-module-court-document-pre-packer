variable "env" {
  description = "Name of the environment to deploy"
  type        = string
}

variable "prefix" {
  description = "Transformation Engine prefix"
  type        = string
}

variable "account_id" {
  description = "Account ID where Image for the Lambda function will be"
  type        = string
}

variable "tre_permission_boundary_arn" {
  description = "ARN of the TRE permission boundary policy"
  type = string
}

variable "tre_internal_topic_arn" {
  description = "ARN of the tre-out sns topic"
  type = string
}

variable "court_document_pre_pack_image_versions" {
  description = "Latest version of Images for the court document pre pack Lambda Functions"
  type = object({
    tre_court_document_pre_pack = string
  })
}

variable "ecr_uri_host" {
  description = "The hostname part of the management account ECR repository; e.g. ACCOUNT.dkr.ecr.REGION.amazonaws.com"
  type = string
}

variable "ecr_uri_repo_prefix" {
  description = "The prefix for Docker image repository names to use; e.g. foo/ in ACCOUNT.dkr.ecr.REGION.amazonaws.com/foo/tre-bar"
  type = string
}

variable "success_destination_lambda_arn" {
  description = "The success destination lambda's arn"
  type = string
}

variable "failure_destination_lambda_arn" {
  description = "The failure destination lambda's arn"
  type = string
}
