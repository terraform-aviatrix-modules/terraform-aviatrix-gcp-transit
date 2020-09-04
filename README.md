# Terraform Aviatrix GCP Transit

### Description

This module deploys a VPC and an Aviatrix transit gateway with HA. Defining the Aviatrix Terraform provider is assumed upstream and is not part of this module.

### Compatibility
Module version | Terraform version | Controller version | Terraform provider version
:--- | :--- | :--- | :---
v1.1.0 | 0.12 | | 
v1.0.2 | 0.12 | | 
v1.0.1 | 0.12 | |
v1.0.0 | 0.12 | |

### Diagram

<img src="https://github.com/terraform-aviatrix-modules/terraform-aviatrix-gcp-transit/blob/master/img/transit-vpc-gcp-ha.png?raw=true">

### Usage Example

```
# GCP Transit Module
module "gcp_transit_1" {
  source             = "app.terraform.io/aviatrix-tf-solutions/gcp-transit/aviatrix"
  version            = "1.1.0"

  sub1_cidr          = "10.10.0.0/16"
  sub2_cidr          = "10.20.0.0/16"
  primary_region     = "us-east1"
  ha_region          = "us-east4"
  account            = "GCP"
}
```

### Variables
The following variables are required:

key | value
--- | ---
sub1_cidr | The IP CIDR to be used to create the first subnet
sub2_cidr | The IP CIDR to be used to create the ha subnet (optional when ha_gw is disabled)
primary_region | GCP region to deploy the transit VPC, first subnet and gateway in
ha_region | GCP region to deploy the ha subnet and ha gateway in (optional when ha_gw is disabled)
account | The GCP account name on the Aviatrix controller, under which the controller will deploy this VPC

The following variables are optional:

key | default | value
--- | --- | ---
name | avx-\<primary/ha-region\>-transit | Provide a custom name for VPC and Gateway resources. Result will be avx-\<name\>-transit.
instance_size | n1-standard-1 | Size of the transit gateway instances
ha_gw | true | Set to false te deploy a single transit GW
connected_transit | true | Set to false to disable connected_transit
active_mesh | true | Set to false to disable active_mesh
az1 | "b" | Concatenates with primary_region to form az names. e.g. us-east1b.
az2 | "b" | Concatenates with ha_region to form az names. e.g. us-east4b.

### Outputs

This module will return the following objects:

key | description
--- | ---
vpc | The created vpc as an object with all of it's attributes. This was created using the aviatrix_vpc resource.
transit_gateway | The created Aviatrix transit gateway as an object with all of it's attributes.
