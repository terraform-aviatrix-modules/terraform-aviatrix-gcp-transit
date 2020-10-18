output "vpc" {
  description = "Returns aviatrix_vpc object and all of its attributes"
  value       = aviatrix_vpc.default
}

output "transit_gateway" {
  description = "Return Aviatrix Transit Gateway with all attributes"
  value       = aviatrix_transit_gateway.default
}