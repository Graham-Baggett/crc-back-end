data "aws_caller_identity" "current" {}

variable "api_url" {
  type        = string
  default     = "https://r31nk3e4ck.execute-api.${var.region}.amazonaws.com"
  description = "API Gateway URL for Lambda Visitor Count functions"
}

variable "region" {
  type        = string
  default     = "us-east-1"
  description = "Default region for the application"
}

variable "account_id" {
  type        = string
  default     = data.aws_caller_identity.current.account_id
  description = "AWS Account ID"
}

variable "api_name" {
  type        = string
  default     = "crc-api-infra"
  description = "API Gateway Name"
} 

variable "get_path_part" {
  type        = string
  default     = "get"
  description = "Name of the path ending for the Get Visitor Count Function"
}

variable "put_path_part" {
  type        = string
  default     = "put"
  description = "Name of the path ending for the Put Visitor Count Function"
}
