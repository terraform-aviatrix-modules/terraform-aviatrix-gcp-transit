# Terraform Aviatrix GCP Transit

# This module will be deprecated in favor of the new multi-cloud transit module
The Multi-Cloud can be found here: https://registry.terraform.io/modules/terraform-aviatrix-modules/mc-transit/aviatrix/latest
This legacy module will remain available in the Terraform registry and on Github for the forseable future, but please plan to replace any usage of it with the multi-cloud transit module.
This module will no longer be maintained and updated.

### Description

This module deploys a VPC and an Aviatrix transit gateway with HA. Defining the Aviatrix Terraform provider is assumed upstream and is not part of this module.

### Compatibility
Module version | Terraform version | Controller version | Terraform provider version
:--- | :--- | :--- | :---
v2.0.1 | 0.12 | >=6.2 | >=0.2.17
v2.0.0 | 0.12 | >=6.2 | >=0.2.17
v1.1.1 | 0.12 | | 
v1.1.0 | 0.12 | | 
v1.0.2 | 0.12 | | 
v1.0.1 | 0.12 | |
v1.0.0 | 0.12 | |

### Diagram

<img src="https://github.com/terraform-aviatrix-modules/terraform-aviatrix-gcp-transit/blob/master/img/transit-vpc-gcp-ha.png?raw=true">

### Usage Example

#### Single
```
# GCP Transit Module
module "gcp_transit_1" {
  source             = "terraform-aviatrix-modules/gcp-transit/aviatrix"
  version            = "2.0.1"
  
  account            = "GCP"
  cidr               = "10.10.0.0/16"
  region             = "us-east1"
  ha_gw              = false
}
```

#### HA
```
# GCP Transit Module
module "gcp_ha_transit_1" {
  source             = "terraform-aviatrix-modules/gcp-transit/aviatrix"
  version            = "2.0.1"

  account            = "GCP"
  cidr               = "10.10.0.0/16"
  region             = "us-east1"
}

```

#### Multi-region HA
```
# GCP Transit Module
module "gcp_ha_transit_1" {
  source             = "terraform-aviatrix-modules/gcp-transit/aviatrix"
  version            = "2.0.1"

  account            = "GCP"
  cidr               = "10.10.0.0/16"
  region             = "us-east1"
  
  ha_region          = "us-east4"
  ha_cidr            = "10.20.0.0/16"
}
```

### Variables
The following variables are required:

key | value
--- | ---
cidr | The IP CIDR to be used to create the first subnet
region | GCP region to deploy the transit VPC, subnet and gateway in
account | The GCP account name on the Aviatrix controller, under which the controller will deploy this VPC

The following variables are optional:

key | default | value
--- | --- | ---
name | avx-\<primary/ha-region\>-transit | Provide a custom name for VPC and Gateway resources. Result will be avx-\<name\>-transit.
instance_size | n1-standard-1 | Size of the transit gateway instances
ha_gw | true | Boolean to build HA. Cannot be set to false when ha_region is set.
ha_region | "" | GCP region for multi region HA. HA is multi-az single region by default, but will become multi region when this is set.
ha_cidr | "" | The IP CIDR to be used to create ha_region spoke subnet. Only 
connected_transit | true | Set to false to disable connected_transit
bgp_manual_spoke_advertise_cidrs | | Intended CIDR list to advertise via BGP. Example: "10.2.0.0/16,10.4.0.0/16" 
learned_cidr_approval | false | Switch to true to enable learned CIDR approval
active_mesh | true | Set to false to disable active_mesh
az1 | "b" | Concatenates with primary_region to form az names. e.g. us-east1b.
az2 | "c" | Concatenates with primary_region or ha_region (depending whether ha_region is set) to form az names. e.g. us-east1c.
prefix | true | Boolean to enable prefix name with avx-
suffix | true | Boolean to enable suffix name with -transit
insane_mode | false | Set to true to enable Aviatrix insane mode high-performance encryption
enable_segmentation | false | Switch to true to enable transit segmentation
single_az_ha | true | Set to false if Controller managed Gateway HA is desired
single_ip_snat | false | Enable single_ip mode Source NAT for this container
enable_advertise_transit_cidr  | false | Switch to enable/disable advertise transit VPC network CIDR for a VGW connection
bgp_polling_time  | 50 | BGP route polling time. Unit is in seconds
bgp_ecmp  | false | Enable Equal Cost Multi Path (ECMP) routing for the next hop

### Outputs

This module will return the following objects:

key | description
--- | ---
[vpc](https://registry.terraform.io/providers/AviatrixSystems/aviatrix/latest/docs/resources/aviatrix_vpc) | The created VPC as an object with all of it's attributes. This was created using the aviatrix_vpc resource.
[transit_gateway](https://registry.terraform.io/providers/AviatrixSystems/aviatrix/latest/docs/resources/aviatrix_transit_gateway) | The created Aviatrix transit gateway as an object with all of it's attributes.
