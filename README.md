# Terraform Aviatrix GCP Transit

This module deploys a VPC and an Aviatrix transit gateway with HA. Defining the Aviatrix Terraform provider is assumed upstream and is not part of this module.

<img src="https://gitlab.com/tmavx-tf-engineering/terraform-aviatrix-gcp-transit/-/tree/master/images/transit-vpc-gcp.png"  height="250">

The following variables are required:

key | value
--- | ---
gcp_account_name | The GCP account name on the Aviatrix controller, under which the controller will deploy this VPC
gcp_primary_region | GCP region to deploy the transit VPC, first subnet and gateway in
gcp_ha_region | GCP region to deploy the ha subnet and ha gateway in
gcp_sub1_cidr | The IP CIDR to be used to create the first subnet
gcp_sub2_cidr | The IP CIDR to be used to create the ha subnet


The following variables are optional:

key | default | value
--- | --- | ---
instance_size | n1-standard-1 | Size of the transit gateway instances
 

Outputs
This module will return the following objects:

key | description
--- | ---
transit_vpc | The created vpc as an object with all of it's attributes. This was created using the aviatrix_vpc resource.
transit_gateway | The created Aviatrix transit gateway name
transit_gw_primary_subnet | Name of the primary subnet
transit_gw_ha_subnet | Name of the ha subnet