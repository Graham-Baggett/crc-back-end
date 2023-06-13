variable "compartment_ocid" {
  type        = string
  description = "OCID for the cloud-resume-challenge compartment"
}

variable "db_admin_password" {
  type        = string
  description = "Administrator password for the Autonomous Database"
}

variable "db_display_name" {
  type        = string
  default     = "crc_autonomous_database"
  description = "The Display Name of the Cloud Resume Challenge Autonomous Database"
}

variable "db_name" {
  type        = string
  default     = "crcadb"
  description = "Name of the Cloud Resume Challenge Autonomous Database"
}

variable "db_workload" {
  type        = string
  default     = "OLTP"
  description = "The type of database workload handled by the database (OLTP, DW, Autonomous JSON, or APEX)"
}

variable "is_auto_scaling_enabled" {
  type        = string
  default     = "false"
  description = "Defines whether or not auto-scaling is enabled on the autonomous database"
}

variable "is_free_tier" {
  type        = string
  default     = "true"
  description = "Defines whether or not the given resource is part of the OCI 'Always Free' Tier or not"
}

variable "license_model" {
  type        = string
  default     = "LICENSE_INCLUDED"
  description = "Indicates whether the license is included or part of Bring Your Own License (BYOL)"
}

variable "region" {
  type        = string
  description = "Default region for the application"
}

# variable "table_ddl_statement" {
#   type        = string
#   default     = "CREATE TABLE home_page ( row_id integer, visitor_count integer DEFAULT 0, PRIMARY KEY ( row_id ) )"
#   description = "Creation DDL statement for home_page table"
# }

# variable "table_is_auto_reclaimable" {
#   type        = string
#   default     = "false"
#   description = "Setting for auto-reclaiming DB data"
# }

# variable "table_limits_max_read_units" {
#   type        = string
#   default     = "50"
#   description = "Max number of read capacity units for the home_page table"
# }

# variable "table_limits_max_storage_in_gbs" {
#   type        = string
#   default     = "25"
#   description = "Max storage size for the home_page table"
# }

# variable "table_limits_max_write_units" {
#   type        = string
#   default     = "50"
#   description = "Max number of write capacity units for the home_page table"
# }

#value defined in the variables section in OCI Resource Manager
variable "tenancy_ocid" {
  type        = string
  description = "Tenancy OCID"
}

# variable "visitor_count_table_name" {
#   type        = string
#   default     = "home_page"
#   description = "Name of the NoSQLDB table that stores the visitor count"
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
