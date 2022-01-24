variable "tenancy_ocid" {
    default = ""
}

variable "user_ocid" {
}

variable "fingerprint" {
}

variable "private_key_path" {
}


variable "compartment_ocid" {
}

# Defines the number of instances to deploy
variable "num_instances" {
  default = "5"
}

variable "instance_shape" {
  default = "VM.Standard.A1.Flex"
}

variable "instance_ocpus" {
  default = 1
}

variable "instance_shape_config_memory_in_gbs" {
  default = 1
}

variable "region" {
  default = "us-ashburn-1"
}

variable "security-group-id" {
  type    = list(string)
  default = []
}

variable "subnet" {
  default = ""
}

variable "oci-image" {
  type    = string
  default = ""
}

variable "ssh_authorized_keys" {
  default = ""
}
