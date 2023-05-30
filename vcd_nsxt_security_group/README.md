# VCD Security Group Terraform Module

This Terraform module allows you to create Static Groups (a.k.a. Security Groups) in an existing VMware Cloud Director (VCD) Environment. Static Groups are groups of Data Center Group Orgnization Networks to which Distributed Firewall (DFW) rules apply.  This module can be used to provsion new Security Groups into [Rackspace Technology SDDC Flex](https://www.rackspace.com/cloud/private/software-defined-data-center-flex) VCD Data Center Regions.

## Requirements

| Name | Version |
|------|---------|
| terraform | ~> 1.2 |
| vcd | ~> 3.8.2 |

## Resources

| Name | Type |
|------|------|
| [vcd_nsxt_security_group](https://registry.terraform.io/providers/vmware/vcd/latest/docs/resources/nsxt_security_group) | resource |
| [vcd_nsxt_edgegateway](https://registry.terraform.io/providers/vmware/vcd/latest/docs/data-sources/nsxt_edgegateway) | data source |
| [vcd_vdc_group](https://registry.terraform.io/providers/vmware/vcd/latest/docs/data-sources/vdc_group) | data source |
| [vcd_network_routed_v2](https://registry.terraform.io/providers/vmware/vcd/latest/docs/data-sources/network_routed_v2) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| vdc_org_name | The name of the Data Center Group Organization in VCD | string | - | yes |
| vdc_group_name | The name of the Data Center Group in VCD | string | - | yes |
| vcd_edge_name | Name of the Data Center Group Edge Gateway | string | - | yes |
| org_network_names | List of network names to be fetched | list(object({ name = string })) | [] | yes |
| security_groups | Map of security groups with names, descriptions, and corresponding org network names | map(object({ description = string, org_network_names = list(string) })) | {} | yes |

## Outputs

| Name | Description |
|------|-------------|
| vdc_group_id | ID of the VDC Group |
| edge_gateway_id | ID of the Edge Gateway |
| org_vdc_routed_network_ids | Map of org VDC routed network IDs |
| security_group_ids | Map of created security group IDs |

## Example Usage

```terraform
module "vcd_security_group" {
  source              = "github.com/global-vmware/vcd_security_group.git?ref=v1.1.0"

  vdc_org_name          = "<US1-VDC-ORG-NAME>"
  vdc_group_name        = "<US1-VDC-GRP-NAME>"
  vdc_edge_name         = "<US1-VDC-EDGE-NAME>"

  org_network_names = [
    {
        name = "US1-Segment-01"
    },
    {
        name = "US1-Segment-02"
    },
    {
        name = "US1-Segment-03"
    },
    {
        name = "US1-Segment-04"
    },
    {
        name = "US1-Segment-05"
    }
  ]

  security_groups = {
    "US1-Segment-01_Static-Group" = {
        description       = "US1 Segment 01 Security Group"
        org_network_names = ["US1-Segment-01"]
    },
    "US1-Segment-02_Static-Group" = {
        description       = "US1 Segment 02 Security Group"
        org_network_names = ["US1-Segment-02"]
    },
    "US1-Segment-03_Static-Group" = {
        description       = "US1 Segment 03 Security Group"
        org_network_names = ["US1-Segment-03"]
    },
    "US1-Segment-04_Static-Group" = {
        description       = "US1 Segment 04 Security Group"
        org_network_names = ["US1-Segment-04"]
    },
    "US1-Segment-05_Static-Group" = {
        description       = "US1 Segment 05 Security Group"
        org_network_names = ["US1-Segment-05"]
    }  
  }
}
```

## Authors

This module is maintained by the [Global VMware Cloud Automation Services Team](https://github.com/global-vmware).