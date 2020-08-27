# Transit VPC
# Information on GCP Regions and Zones https://cloud.google.com/compute/docs/regions-zones
# GCP zones b,c are almost universally available that's why we chose them

resource "aviatrix_vpc" "single" {
  count                = var.ha_gw ? 0 : 1
  cloud_type           = 4
  account_name         = var.account
  name                 = length(var.name) > 0 ? "avx-${var.name}-transit" : "avx-${var.primary_region}-transit"
  aviatrix_transit_vpc = false
  aviatrix_firenet_vpc = false
  subnets {
    name   = "transit-subnet-${var.primary_region}"
    cidr   = var.sub1_cidr
    region = var.primary_region
  }
}

resource "aviatrix_vpc" "ha" {
  count                = var.ha_gw ? 1 : 0
  cloud_type           = 4
  account_name         = var.account
  name                 = "transit-vpc-${var.primary_region}"
  aviatrix_transit_vpc = false
  aviatrix_firenet_vpc = false
  subnets {
    name   = length(var.name) > 0 ? "avx-${var.name}-transit-primary" : "avx-${var.primary_region}-transit"
    cidr   = var.sub1_cidr
    region = var.primary_region
  }

  subnets {
    name   = length(var.name) > 0 ? "avx-${var.name}-transit-ha" : "avx-${var.ha_region}-transit"
    cidr   = var.sub2_cidr
    region = var.ha_region
  }
}

resource "aviatrix_transit_gateway" "single" {
  count              = var.ha_gw ? 0 : 1
  gw_name            = length(var.name) > 0 ? "avx-${var.name}-transit" : "avx-${var.primary_region}-transit"
  vpc_id             = aviatrix_vpc.single[0].name
  cloud_type         = 4
  vpc_reg            = "${var.primary_region}-${var.az1}"
  enable_active_mesh = var.active_mesh
  gw_size            = var.instance_size
  account_name       = var.account
  subnet             = var.sub1_cidr
  connected_transit  = var.connected_transit
}

resource "aviatrix_transit_gateway" "ha" {
  count              = var.ha_gw ? 1 : 0
  gw_name            = length(var.name) > 0 ? "avx-${var.name}-transit" : "avx-${var.primary_region}-transit"
  vpc_id             = aviatrix_vpc.ha[0].name
  cloud_type         = 4
  vpc_reg            = "${var.primary_region}-${var.az1}"
  enable_active_mesh = var.active_mesh
  gw_size            = var.instance_size
  account_name       = var.account
  subnet             = var.sub1_cidr
  ha_subnet          = var.sub2_cidr
  ha_gw_size         = var.instance_size
  ha_zone            = "${var.ha_region}-${var.az2}"
  connected_transit  = var.connected_transit
}


