variable "username" {
  type    = string
  default = ""
}

variable "password" {
  type    = string
  default = ""
}

variable "controller_ip" {
  type    = string
  default = ""
}

variable "gcp_primary_region" {
  description = "Primary GCP region where subnet and Aviatrix Transit Gateway will be created"
  default = ""
}

variable "gcp_ha_region" {
  description = "Secondary GCP region where subnet and HA Aviatrix Transit Gateway will be created"
  default = ""
}

variable "gcp_account_name" {
  description = "Name of the GCP Access Account defined in the Aviatrix Controller"
  default = ""
}

variable "gcp_gw_size" {
  description = "Size of the compute instance for the Aviatrix Gateways"
  default = "n1-standard-1"
}

variable "gcp_sub1_cidr" {
  description = "CIDR of the primary GCP subnet"
  default = ""
}

variable "gcp_sub2_cidr" {
  description = "CIDR of the HA GCP subnet"
  default = ""
}
