## Data Center Group Routed Network Terraform Module

This Terraform module will deploy a Data Center Group Routed Network into an existing VMware Cloud Director (VCD) Environment.  This module can be used to provsion new Data Center Group Networks into [Rackspace Technology SDDC Flex](https://www.rackspace.com/cloud/private/software-defined-data-center-flex) VCD Data Center Regions.

## Requirements

| Name | Version |
|------|---------|
| terraform | ~> 1.2 |
| vcd | ~> 3.8.2 |

## Resources

| Name | Type |
|------|------|
| [vcd_vdc_group](https://registry.terraform.io/providers/vmware/vcd/3.8.2/docs/data-sources/vdc_group) | data source |
| [vcd_nsxt_edgegateway](https://registry.terraform.io/providers/vmware/vcd/3.8.2/docs/data-sources/nsxt_edgegateway) | data source |
| [vcd_network_routed_v2](https://registry.terraform.io/providers/vmware/vcd/3.8.2/docs/resources/network_routed_v2) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| vdc_org_name | The name of the Data Center Group Organization in VCD | string | `"Organization Name Format: <Account_Number>-<Region>-<Account_Name>"` | yes |
| vdc_group_name | The name of the Data Center Group in VCD | string | `"Data Center Group Name Format: <Account_Number>-<Region>-<Account_Name> <datacenter group>"` | yes |
| vdc_edge_name | Name of the Data Center Group Edge Gateway | string | `"Edge Gateway Name Format: <Account_Number>-<Region>-<Edge_GW_Identifier>-<edge>"` | yes |
| segments | A map of objects defining the segments to be created. | map(object({<br>  gateway = string,<br>  prefix_length = number,<br>  dns1 = string,<br>  dns2 = string,<br>  dns_suffix = string,<br>  start_address = string,<br>  end_address = string<br>})) | `{Segment-01 = {gateway = "192.168.0.1", prefix_length = 24, dns1 = "192.168.255.228", dns2 = "", dns_suffix = "domain.com", start_address = "192.168.0.50", end_address = "192.168.0.100"}, Segment-02 = {gateway = "192.168.1.1", prefix_length = 24, dns1 = "192.168.255.228", dns2 = "", dns_suffix = "domain.com", start_address = "192.168.1.50", end_address = "192.168.1.100"}}` | no |


`NOTE:`Each object in the `segments` map must have the following attributes:

`gateway`: The gateway IP address for the segment.
`prefix_length`: The CIDR notation prefix length for the segment.
`start_address`: The start IP address of the static IP pool for the segment.
`end_address`: The end IP address of the static IP pool for the segment.
`dns1_address`: The primary DNS server address for the segment.
`dns2_address`: The secondary DNS server address for the segment. This field can be left empty.
`dns_suffix`: The DNS suffix for the segment.

## Outputs

| Name | Description |
|------|-------------|
| segment_inputs | This Output will provide a list of all the Data Center Group Routed Networks and their assigned attributes.


## Example Usage
This is an example of a main.tf file that would use the "github.com/global-vmware/vcd-network-routed-v2" Module Source to create a Data Center Group Routed Network.

The Terraform code example for the main.tf file is below:

```terraform
module "org_vdc_routed_network" {
  source          = "github.com/global-vmware/vcd_network_routed_v2.git?ref=v1.2.1"
  
  vdc_group_name      = "<US1-VDC-GRP-NAME>"
  vdc_org_name        = "<US1-VDC-ORG-NAME>"
  vdc_edge_name       = "<US1-VDC-EDGE-NAME>"

  segments = {
    US1-Segment-01 = {
      gateway       = "172.16.0.1"
      prefix_length = 24
      start_address = "172.16.0.50"
      end_address   = "172.16.0.100"
      dns1          = "192.168.255.228"
      dns2          = ""
      dns_suffix    = "mydomain.com"
    },
    US1-Segment-02 = {
      gateway       = "172.16.1.1"
      prefix_length = 24
      start_address = "172.16.1.50"
      end_address   = "172.16.1.100"
      dns1          = "192.168.255.228"
      dns2          = ""
      dns_suffix    = "mydomain.com"
    }
  }
}
```

## Authors

This module is maintained by the [Global VMware Cloud Automation Services Team](https://github.com/global-vmware).