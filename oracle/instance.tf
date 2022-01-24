provider "oci" {
  region = "us-ashburn-1"
}

data "oci_identity_availability_domain" "ad" {
  compartment_id = var.tenancy_ocid
  ad_number      = 1
}

data "oci_identity_region_subscriptions" "test_region_subscriptions" {
  #Required
  tenancy_id = var.tenancy_ocid
}

resource "oci_core_instance" "genymotion-paas-oci" {

  count = var.num_instances
  agent_config {
    is_management_disabled = "false"
    is_monitoring_disabled = "false"
  }

  availability_config {
    recovery_action = "RESTORE_INSTANCE"
  }

  availability_domain = data.oci_identity_availability_domain.ad.name
  compartment_id      = var.tenancy_ocid

  create_vnic_details {
    assign_public_ip = "true"
    nsg_ids          = var.security-group-id
    subnet_id        = var.subnet
  }
  display_name = "DEMO-${var.oci-image}"

  instance_options {
    are_legacy_imds_endpoints_disabled = "false"
  }

  metadata = {
    ssh_authorized_keys = file(var.ssh_authorized_keys)
  }

  shape = var.instance_shape
  shape_config {
    memory_in_gbs = var.instance_shape_config_memory_in_gbs
    ocpus         = var.instance_ocpus
  }

  source_details {
    source_id   = var.oci-image
    source_type = "image"
  }

}
