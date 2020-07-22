output "transit_vpc" {
  description = "Returns aviatrix_vpc object and all of its attributes"
  value = var.ha_gw ? aviatrix_vpc.ha[0] : aviatrix_vpc.single[0]
}

output "transit_gateway" {
  description = "Return Aviatrix Transit Gateway with all attributes"
  value = var.ha_gw ? aviatrix_transit_gateway.ha[0] : aviatrix_transit_gateway.single[0]
}