variable "compartment_ocid" {
  type        = string
  description = "OCID for the cloud-resume-challenge compartment"
}

variable "region" {
  type        = string
  description = "Default region for the application"
}

variable "table_ddl_statement" {
  type        = string
  default     = "CREATE TABLE home_page ( row_id integer, visitor_count integer DEFAULT 0, PRIMARY KEY ( row_id ) )"
  description = "Creation DDL statement for home_page table"
}

variable "table_is_auto_reclaimable" {
  type        = string
  default     = "false"
  description = "Setting for auto-reclaiming DB data"
}

variable "table_limits_max_read_units" {
  type        = string
  default     = "50"
  description = "Max number of read capacity units for the home_page table"
}

variable "table_limits_max_storage_in_gbs" {
  type        = string
  default     = "25"
  description = "Max storage size for the home_page table"
}

variable "table_limits_max_write_units" {
  type        = string
  default     = "50"
  description = "Max number of write capacity units for the home_page table"
}

variable "visitor_count_table_name" {
  type        = string
  default     = "home_page"
  description = "Name of the NoSQLDB table that stores the visitor count"
}

# variable "api_name" {
#   type        = string
#   default     = "crc-api-infra"
#   description = "API Gateway Name"
# }

# variable "get_path_part" {
#   type        = string
#   default     = "get"
#   description = "Name of the path ending for the Get Visitor Count Function"
# }

# variable "put_path_part" {
#   type        = string
#   default     = "put"
#   description = "Name of the path ending for the Put Visitor Count Function"
# }



# variable "billing_mode" {
#   type        = string
#   default     = "PAY_PER_REQUEST"
#   description = "Billing mode of the DynamoDB table that stores the visitor count"
# }

# variable "attribute_name" {
#   type        = string
#   default     = "record_id"
#   description = "Primary key name of the DynamoDB table that stores the visitor count"
# }
