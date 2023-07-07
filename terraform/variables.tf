variable "ad_number" { default = 3 }

variable "boot_volume_size_in_gbs" { default = 50 }

variable "compartment_ocid" {
  type        = string
  description = "OCID for the cloud-resume-challenge compartment"
}

variable "db_admin_password" {
  type        = string
  description = "Administrator password for the Autonomous Database"
}

variable "db_wallet_password" {
  type        = string
  description = "Wallet password for the Autonomous Database"
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

variable export_free_instance1_source_image_id { default = "ocid1.image.oc1.iad.aaaaaaaarxv4fl2ktujk4amgkfj4g2tjju5dlzym644cmqfzpno3jlypuzva" }

variable "instance_ocpus" { default = 1 }

variable "instance_shape" {
  default = "VM.Standard.E2.1.Micro" # Or VM.Standard.A1.Flex
}

variable "instance_shape_config_memory_in_gbs" { default = 1 } #24

variable "is_access_control_enabled" {
  type        = string
  default     = "true"
  description = "Defines whether or not database-level access control is enabled"
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

variable "is_mtls_connection_required" {
  type        = string
  default     = "false"
  description = "Defines whether or not the database requires mutual Transport Layer Security connections"
}

variable "license_model" {
  type        = string
  default     = "LICENSE_INCLUDED"
  description = "Indicates whether the license is included or part of Bring Your Own License (BYOL)"
}

variable "public_subnet_name" {
  type        = string
  default     = "cloud-resume-challenge-public-subnet"
  description = "Display Name of the public subnet of the Virtual Cloud Network"
}

variable "private_key_path" {
  default = ""
}

variable "region" {
  type        = string
  description = "Default region for the application"
}

variable "ssh_public_key" {
  default = ""
}

#value defined in the variables section in OCI Resource Manager
variable "tenancy_ocid" {
  type        = string
  description = "Tenancy OCID"
}

variable "whitelisted_ips" {
  description = "Allowable IP Addresses for the database"
}


## variables for NoSQL table, but this service is not currently 'Always Free' in every OCI region
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
