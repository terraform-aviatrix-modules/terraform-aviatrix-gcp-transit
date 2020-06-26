output "transit_vpc" {
  value = aviatrix_vpc.default
}

output "transit_gw_primary_subnet" {
  value = aviatrix_vpc.default.subnets[0].name
}

output "transit_gw_ha_subnet" {
  value = aviatrix_vpc.default.subnets[1].name
}

output "transit_gateway" {
  value = aviatrix_transit_gateway.gcp_transit_gw.gw_name
}
