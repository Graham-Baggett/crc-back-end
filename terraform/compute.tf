data "oci_core_images" "oracle_linux_images" {
  compartment_id           = var.compartment_ocid
  operating_system         = "Oracle Linux"
  operating_system_version = "8"
  shape                    = var.instance_shape
  sort_by                  = "TIMECREATED"
  sort_order               = "DESC"
}

data "oci_core_subnets" "public_subnets" {
    #Required
    compartment_id = var.compartment_ocid

    #Optional
    display_name = var.public_subnet_name
}

data "oci_identity_availability_domain" "ad" {
  compartment_id = var.tenancy_ocid
  ad_number      = 1
}

resource oci_core_instance export_free_instance1 {
  agent_config {
    are_all_plugins_disabled = "false"
    is_management_disabled   = "false"
    is_monitoring_disabled   = "false"
    plugins_config {
      desired_state = "DISABLED"
      name          = "Vulnerability Scanning"
    }
    plugins_config {
      desired_state = "DISABLED"
      name          = "Oracle Java Management Service"
    }
    plugins_config {
      desired_state = "ENABLED"
      name          = "OS Management Service Agent"
    }
    plugins_config {
      desired_state = "ENABLED"
      name          = "Compute Instance Run Command"
    }
    plugins_config {
      desired_state = "ENABLED"
      name          = "Compute Instance Monitoring"
    }
    plugins_config {
      desired_state = "DISABLED"
      name          = "Block Volume Management"
    }
    plugins_config {
      desired_state = "DISABLED"
      name          = "Bastion"
    }
  }
  #async = <<Optional value not found in discovery>>
  availability_config {
    #is_live_migration_preferred = <<Optional value not found in discovery>>
    recovery_action = "RESTORE_INSTANCE"
  }
  availability_domain = "IPsT:US-ASHBURN-AD-1"
  #capacity_reservation_id = <<Optional value not found in discovery>>
  compartment_id = var.compartment_ocid
  create_vnic_details {
    #assign_private_dns_record = <<Optional value not found in discovery>>
    assign_public_ip = "true"
    defined_tags = {
      "Oracle-Tags.CreatedBy" = "default/grahambaggett@gmail.com"
      "Oracle-Tags.CreatedOn" = "2023-06-16T13:21:54.123Z"
    }
    display_name = "vnic20230616132159"
    freeform_tags = {
    }
    #hostname_label = <<Optional value not found in discovery>>
    nsg_ids = [
    ]
    private_ip             = "10.0.2.112"
    skip_source_dest_check = "false"
    subnet_id              = data.oci_core_subnets.public_subnets.id
    #vlan_id = <<Optional value not found in discovery>>
  }
  #dedicated_vm_host_id = <<Optional value not found in discovery>>
  defined_tags = {
    "Oracle-Tags.CreatedBy" = "default/grahambaggett@gmail.com"
    "Oracle-Tags.CreatedOn" = "2023-06-16T13:21:53.926Z"
  }
  display_name = "free_instance1"
  extended_metadata = {
  }
  fault_domain = "FAULT-DOMAIN-1"
  freeform_tags = {
  }
  instance_options {
    are_legacy_imds_endpoints_disabled = "false"
  }
  #ipxe_script = <<Optional value not found in discovery>>
  #is_pv_encryption_in_transit_enabled = <<Optional value not found in discovery>>
  launch_options {
    boot_volume_type                    = "PARAVIRTUALIZED"
    firmware                            = "UEFI_64"
    is_consistent_volume_naming_enabled = "true"
    is_pv_encryption_in_transit_enabled = "false"
    network_type                        = "PARAVIRTUALIZED"
    remote_data_volume_type             = "PARAVIRTUALIZED"
  }
  metadata = {
    "ssh_authorized_keys" = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDMzeMojo/qz2gZNWPcO42VInYL+PyeVFXmUGhrG+WjVx3fUP4ZQY1VFegvIJ93Xb621k1nfVkcq69iXqbL4Pv0m8tdOqPzJYcFTu607C9RB+xIddKrFvgn59xxuFF4gwMdyyfED8aI4lFecuUzQCYLqD9T6Gq1IndxFKwKaU2Wu6i29Ivgbu1eqziW3gGJawqLe3mnTvmpXN8XnwOExRGneeI8uHeiUHKMe2lueOU6n1nHeEpQGstlqkbjrlFfcIhwcotLyEj5DmYd+X/HfgATB7Azfr1TsW8Wmb0ymobVSfZAweZGhFAsjd6TMQKY3CFvPs1wI9B1SfAuTJoBN8Jv ssh-key-2023-06-16"
  }
  #preserve_boot_volume = <<Optional value not found in discovery>>
  shape = "VM.Standard.A1.Flex"
  shape_config {
    baseline_ocpu_utilization = ""
    memory_in_gbs             = "6"
    ocpus                     = "1"
  }
  source_details {
    #boot_volume_size_in_gbs = <<Optional value not found in discovery>>
    #kms_key_id = <<Optional value not found in discovery>>
    source_id   = var.export_free_instance1_source_image_id
    source_type = "image"
  }
  state = "RUNNING"
}

# resource "oci_core_instance" "free_instance1" {
#   availability_domain = data.oci_identity_availability_domain.ad.name
#   compartment_id      = var.compartment_ocid
#   display_name        = "freeInstance1"
#   shape               = var.instance_shape

#   shape_config {
#     ocpus = 1
#     memory_in_gbs = 6
#   }

#   create_vnic_details {
#     subnet_id        = data.oci_core_subnets.public_subnets.id
#     display_name     = "primaryvnic"
#     assign_public_ip = true
#     hostname_label   = "freeinstance1"
#   }

#   source_details {
#     source_type = "image"
#     source_id   = lookup(data.oci_core_images.oracle_linux_images.images[0], "id")
#   }

#   metadata = {
#     ssh_authorized_keys = (var.ssh_public_key != "") ? var.ssh_public_key : tls_private_key.compute_ssh_key.public_key_openssh
#   }
# }

resource "tls_private_key" "compute_ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

output "generated_private_key_pem" {
  value     = (var.ssh_public_key != "") ? var.ssh_public_key : tls_private_key.compute_ssh_key.private_key_pem
  sensitive = true
}

# The "name" of the availability domain to be used for the compute instance.
output "name-of-first-availability-domain" {
  value = data.oci_identity_availability_domain.ad.name
  #value = data.oci_identity_availability_domains.ads.availability_domains[0].name
}

# The source_id of the Oracle Linux Image
output "oracle-linux-image-source-id" {
  value = lookup(data.oci_core_images.oracle_linux_images.images[0], "id")
}

output "public-subnet-id" {
  value = data.oci_core_subnets.public_subnets.id
}
