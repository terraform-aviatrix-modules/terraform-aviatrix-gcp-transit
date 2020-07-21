output "transit_vpc" {
  description = "Returns aviatrix_vpc object and all of its attributes"
  value = var.ha_gw ? aviatrix_vpc.ha[0] : aviatrix_vpc.single[0]
}

/*
output "transit_gw_primary_subnet" {
  description = "Returns primary GCP subnet name for Aviatrix Transit Gateway"
  value = aviatrix_vpc.default.subnets[0].name
}

output "transit_gw_ha_subnet" {
  value = aviatrix_vpc.default.subnets[1].name
}
*/

output "transit_gateway" {
  description = "Return Aviatrix Transit Gateway with all attributes"
  value = var.ha_gw ? aviatrix_transit_gateway.ha[0] : aviatrix_transit_gateway.single[0]
}