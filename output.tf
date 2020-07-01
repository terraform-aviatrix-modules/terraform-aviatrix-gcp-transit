output "transit_vpc" {
  description = "Returns aviatrix_vpc object and all of its attributes"
  value = aviatrix_vpc.default
}

output "transit_gw_primary_subnet" {
  description = "Returns primary GCP subnet name for Aviatrix Transit Gateway"
  value = aviatrix_vpc.default.subnets[0].name
}

output "transit_gw_ha_subnet" {
  value = aviatrix_vpc.default.subnets[1].name
}

output "transit_gateway" {
  description = "Returns name of Aviatrix Transit Gateway"
  value = aviatrix_transit_gateway.gcp_transit_gw.gw_name
}
