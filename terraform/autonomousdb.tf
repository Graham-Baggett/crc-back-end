data "oci_database_autonomous_databases" "crc_autonomous_databases" {
  #Required
  compartment_id = var.compartment_ocid

  #Optional
  db_workload  = var.db_workload
  is_free_tier = var.is_free_tier
}

resource "oci_database_autonomous_database" "crc_autonomous_database" {
  #Required
  admin_password           = var.db_admin_password
  compartment_id           = var.compartment_ocid
  cpu_core_count           = "1"
  data_storage_size_in_tbs = "1"
  db_name                  = var.db_name

  #Optional
  db_workload  = var.db_workload
  display_name = var.db_display_name

  is_auto_scaling_enabled = var.is_auto_scaling_enabled
  license_model           = var.license_model
  is_free_tier            = var.is_free_tier
}

#resource "oci_database_autonomous_database_wallet" "crc_autonomous_database_wallet" {
#    #Required
#    autonomous_database_id = data.oci_database_autonomous_databases.crc_autonomous_databases.id
#    password = var.db_wallet_password

    #Optional
#    base64_encode_content = "true"
#    generate_type = "SINGLE"
#}

output "crc-autonomous-database-id" {
  value = data.oci_database_autonomous_databases.crc_autonomous_databases.autonomous_databases[0].id
}
