# Outputs

output "ip_address" {
  value = oci_core_instance.genymotion-paas-oci.*.public_ip
}

output "token" {
  value = oci_core_instance.genymotion-paas-oci.*.display_name
}
