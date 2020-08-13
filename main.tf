# Transit VPC
# Information on GCP Regions and Zones https://cloud.google.com/compute/docs/regions-zones
# GCP zones b,c are almost universally available that's why we chose them

resource "aviatrix_vpc" "single" {
  count                = var.ha_gw ? 0 : 1
  cloud_type           = 4
  account_name         = var.gcp_account_name
  name                 = "transit-vpc-${var.gcp_primary_region}"
  aviatrix_transit_vpc = false
  aviatrix_firenet_vpc = false
  subnets {
    name   = "transit-subnet-${var.gcp_primary_region}"
    cidr   = var.gcp_sub1_cidr
    region = var.gcp_primary_region
  }
}

resource "aviatrix_vpc" "ha" {
  count                = var.ha_gw ? 1 : 0
  cloud_type           = 4
  account_name         = var.gcp_account_name
  name                 = "transit-vpc-${var.gcp_primary_region}"
  aviatrix_transit_vpc = false
  aviatrix_firenet_vpc = false
  subnets {
    name   = "transit-subnet-${var.gcp_primary_region}"
    cidr   = var.gcp_sub1_cidr
    region = var.gcp_primary_region
  }

  subnets {
    name   = "transit-subnet-${var.gcp_ha_region}"
    cidr   = var.gcp_sub2_cidr
    region = var.gcp_ha_region
  }
}

resource "aviatrix_transit_gateway" "single" {
  count              = var.ha_gw ? 0 : 1
  gw_name            = "avx-${var.gcp_primary_region}-transit-gw"
  vpc_id             = aviatrix_vpc.single[0].name
  cloud_type         = 4
  vpc_reg            = "${var.gcp_primary_region}-b"
  enable_active_mesh = true
  gw_size            = var.gcp_gw_size
  account_name       = var.gcp_account_name
  subnet             = var.gcp_sub1_cidr
}

resource "aviatrix_transit_gateway" "ha" {
  count              = var.ha_gw ? 1 : 0
  gw_name            = "avx-${var.gcp_primary_region}-transit-gw"
  vpc_id             = aviatrix_vpc.ha[0].name
  cloud_type         = 4
  vpc_reg            = "${var.gcp_primary_region}-b"
  enable_active_mesh = true
  gw_size            = var.gcp_gw_size
  account_name       = var.gcp_account_name
  subnet             = var.gcp_sub1_cidr
  ha_subnet          = var.gcp_sub2_cidr
  ha_gw_size         = var.gcp_gw_size
  ha_zone            = "${var.gcp_ha_region}-c"
}


