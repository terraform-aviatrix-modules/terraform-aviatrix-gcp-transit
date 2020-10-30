# Transit VPC
# Information on GCP Regions and Zones https://cloud.google.com/compute/docs/regions-zones
# GCP zones b,c are almost universally available that's why we chose them

resource "aviatrix_vpc" "single_region" {
  count                = length(var.ha_region) > 0 ? 0 : 1
  cloud_type           = 4
  account_name         = var.account
  name                 = length(var.name) > 0 ? "avx-${var.name}-transit" : "avx-${var.region}-transit"
  aviatrix_transit_vpc = false
  aviatrix_firenet_vpc = false
  subnets {
    name   = "transit-subnet-${var.region}"
    cidr   = var.cidr
    region = var.region
  }
}

resource "aviatrix_vpc" "ha_region" {
  count                = length(var.ha_region) > 0 ? 1 : 0
  cloud_type           = 4
  account_name         = var.account
  name                 = length(var.name) > 0 ? "avx-${var.name}-transit" : "avx-${var.region}-transit"
  aviatrix_transit_vpc = false
  aviatrix_firenet_vpc = false
  subnets {
    name   = length(var.name) > 0 ? "avx-${var.name}-transit" : "avx-${var.region}-transit"
    cidr   = var.cidr
    region = var.region
  }

  subnets {
    name   = length(var.name) > 0 ? "avx-${var.name}-transit-ha" : "avx-${var.ha_region}-transit"
    cidr   = var.ha_cidr
    region = var.ha_region
  }
}

resource "aviatrix_transit_gateway" "single" {
  count                            = var.ha_gw ? 0 : 1
  gw_name                          = length(var.name) > 0 ? "avx-${var.name}-transit" : "avx-${var.region}-transit"
  vpc_id                           = aviatrix_vpc.single_region[0].name
  cloud_type                       = 4
  vpc_reg                          = "${var.region}-${var.az1}"
  enable_active_mesh               = var.active_mesh
  gw_size                          = var.instance_size
  account_name                     = var.account
  subnet                           = var.cidr
  connected_transit                = var.connected_transit
  bgp_manual_spoke_advertise_cidrs = var.bgp_manual_spoke_advertise_cidrs
  enable_learned_cidrs_approval    = var.learned_cidr_approval
  single_ip_snat                   = var.single_ip_snat
  enable_segmentation              = var.enable_segmentation
  enable_advertise_transit_cidr    = var.enable_advertise_transit_cidr
  #enable_firenet                   = var.enable_firenet
  #enable_transit_firenet           = var.enable_transit_firenet
  #enable_egress_transit_firenet    = var.enable_egress_transit_firenet
  bgp_polling_time = var.bgp_polling_time
  bgp_ecmp         = var.bgp_ecmp
}

resource "aviatrix_transit_gateway" "ha" {
  count                            = var.ha_gw ? 1 : 0
  gw_name                          = length(var.name) > 0 ? "avx-${var.name}-transit" : "avx-${var.region}-transit"
  vpc_id                           = length(var.ha_region) > 0 ? aviatrix_vpc.ha_region[0].name : aviatrix_vpc.single_region[0].name
  cloud_type                       = 4
  vpc_reg                          = "${var.region}-${var.az1}"
  enable_active_mesh               = var.active_mesh
  gw_size                          = var.instance_size
  account_name                     = var.account
  subnet                           = length(var.ha_region) > 0 ? aviatrix_vpc.ha_region[0].subnets[0].cidr : aviatrix_vpc.single_region[0].subnets[0].cidr
  ha_subnet                        = length(var.ha_region) > 0 ? aviatrix_vpc.ha_region[0].subnets[1].cidr : aviatrix_vpc.single_region[0].subnets[0].cidr
  ha_gw_size                       = var.instance_size
  ha_zone                          = length(var.ha_region) > 0 ? "${var.ha_region}-${var.az2}" : "${var.region}-${var.az2}"
  connected_transit                = var.connected_transit
  bgp_manual_spoke_advertise_cidrs = var.bgp_manual_spoke_advertise_cidrs
  enable_learned_cidrs_approval    = var.learned_cidr_approval
  single_ip_snat                   = var.single_ip_snat
  enable_segmentation              = var.enable_segmentation
  enable_advertise_transit_cidr    = var.enable_advertise_transit_cidr
  #enable_firenet                   = var.enable_firenet
  #enable_transit_firenet           = var.enable_transit_firenet
  #enable_egress_transit_firenet    = var.enable_egress_transit_firenet
  bgp_polling_time = var.bgp_polling_time
  bgp_ecmp         = var.bgp_ecmp
}


