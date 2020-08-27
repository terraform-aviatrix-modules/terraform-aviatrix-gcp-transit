variable "primary_region" {
  description = "Primary GCP region where subnet and Aviatrix Transit Gateway will be created"
}

variable "ha_region" {
  description = "Secondary GCP region where subnet and HA Aviatrix Transit Gateway will be created"
  default     = ""
}

variable "account" {
  description = "Name of the GCP Access Account defined in the Aviatrix Controller"
}

variable "instance_size" {
  description = "Size of the compute instance for the Aviatrix Gateways"
  default     = "n1-standard-1"
}

variable "sub1_cidr" {
  description = "CIDR of the primary GCP subnet"
}

variable "sub2_cidr" {
  description = "CIDR of the HA GCP subnet"
  default     = ""
}

variable "ha_gw" {
  description = "Set to false te deploy a single transit GW"
  type        = bool
  default     = true
}

variable "az1" {
  type    = string
  default = "b"
}

variable "az2" {
  type    = string
  default = "c"
}

variable "name" {
  type    = string
  default = ""
}

variable "connected_transit" {
  description = ""
  type        = bool
  default     = true
}

variable "active_mesh" {
  description = ""
  type        = bool
  default     = true
}
