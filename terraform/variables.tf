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
