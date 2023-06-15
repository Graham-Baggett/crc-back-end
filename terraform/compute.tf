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
