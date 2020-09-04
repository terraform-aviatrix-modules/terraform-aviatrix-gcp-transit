variable "primary_region" {
  description = "Primary GCP region where subnet and Aviatrix Transit Gateway will be created"
  type        = string
}

variable "ha_region" {
  description = "Secondary GCP region where subnet and HA Aviatrix Transit Gateway will be created"
  default     = ""
  type        = string
}

variable "account" {
  description = "Name of the GCP Access Account defined in the Aviatrix Controller"
  type        = string
}

variable "instance_size" {
  description = "Size of the compute instance for the Aviatrix Gateways"
  default     = "n1-standard-1"
  type        = string
}

variable "sub1_cidr" {
  description = "CIDR of the primary GCP subnet"
  type        = string
}

variable "sub2_cidr" {
  description = "CIDR of the HA GCP subnet"
  type        = string
  default     = ""
}

variable "ha_gw" {
  description = "Set to false te deploy a single transit GW"
  type        = bool
  default     = true
}

variable "az1" {
  description = "Concatenates with primary_region to form az names. e.g. us-east1b."
  type        = string
  default     = "b"
}

variable "az2" {
  description = "Concatenates with ha_region to form az names. e.g. us-east4b."
  type        = string
  default     = "b"
}

variable "name" {
  description = "Name for this spoke VPC and it's gateways"
  type        = string
  default     = ""
}

variable "connected_transit" {
  description = "Set to false to disable connected transit."
  type        = bool
  default     = true
}

variable "active_mesh" {
  description = "Set to false to disable active mesh."
  type        = bool
  default     = true
}
