resource "oci_nosql_table" "home_page" {
  compartment_id = var.compartment_ocid
  ddl_statement  = var.table_ddl_statement
  defined_tags = {
    "Oracle-Tags.CreatedBy" = "default/grahambaggett@gmail.com"
    "Oracle-Tags.CreatedOn" = "2023-05-24T13:28:40.438Z"
  }
  is_auto_reclaimable = var.table_is_auto_reclaimable
  name                = var.visitor_count_table_name
  table_limits {
    max_read_units     = var.table_limits_max_read_units"50"
    max_storage_in_gbs = var.table_limits_max_storage_in_gbs"25"
    max_write_units    = var.table_limits_max_write_units"50"
  }
}
