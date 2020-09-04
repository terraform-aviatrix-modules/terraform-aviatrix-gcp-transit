output "vpc" {
  description = "Returns aviatrix_vpc object and all of its attributes"
  value       = var.ha_region ? aviatrix_vpc.ha_region[0] : aviatrix_vpc.single_region[0]
}

output "transit_gateway" {
  description = "Return Aviatrix Transit Gateway with all attributes"
  value       = var.ha_gw ? aviatrix_transit_gateway.ha[0] : aviatrix_transit_gateway.single[0]
}