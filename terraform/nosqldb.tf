resource "oci_nosql_table" "home_page" {
  compartment_id = var.compartment_ocid
  ddl_statement  = var.table_ddl_statement
  defined_tags = {
    "Oracle-Tags.CreatedBy" = "default/grahambaggett@gmail.com"
  }
  is_auto_reclaimable = var.table_is_auto_reclaimable
  name                = var.visitor_count_table_name
  table_limits {
    max_read_units     = var.table_limits_max_read_units
    max_storage_in_gbs = var.table_limits_max_storage_in_gbs
    max_write_units    = var.table_limits_max_write_units
  }
}
