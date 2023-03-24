variable "region" {
  type        = string
  default     = "us-east-1"
  description = "Default region for the application"
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
