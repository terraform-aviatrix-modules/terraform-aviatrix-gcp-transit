# Transit VPC
# Information on GCP Regions and Zones https://cloud.google.com/compute/docs/regions-zones
# GCP zones b,c are almost universally available that's why we chose them

resource "aviatrix_vpc" "default" {
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

# Aviatrix GCP Transit Network Gateway
resource "aviatrix_transit_gateway" "gcp_transit_gw" {
  single_az_ha       = true
  gw_name            = "avx-${var.gcp_primary_region}-transit-gw"
  vpc_id             = aviatrix_vpc.default.name
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


