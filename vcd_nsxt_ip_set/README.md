# Terraform Module for Managing NSX-T IP Sets

This Terraform module manages NSX-T IP sets in VMware Cloud Director (VCD) environments using the `vmware/vcd` provider.

## Requirements

| Name      | Version |
|-----------|---------|
| terraform | >= 1.2  |
| vcd       | >= 3.8.2 |

## Resources

| Name                                                                 | Type         |
|----------------------------------------------------------------------|--------------|
| [vcd_vdc_group](https://registry.terraform.io/providers/vmware/vcd/3.8.2/docs/data-sources/vdc_group) | data source |
| [vcd_nsxt_edgegateway](https://registry.terraform.io/providers/vmware/vcd/3.8.2/docs/data-sources/nsxt_edgegateway) | data source |
| [vcd_nsxt_ip_set](https://registry.terraform.io/providers/vmware/vcd/3.8.2/docs/resources/nsxt_ip_set) | resource |

## Inputs

| Name            | Description                                                      | Type | Default | Required |
|-----------------|------------------------------------------------------------------|------|---------|----------|
| vdc_org_name | The name of the Data Center Group Organization in VCD | string | `"Data Center Group Name Format: <Account_Number>-<Region>-<Account_Name>"` | yes |
| vdc_edge_name | The name of the NSX-T Edge Gateway in VCD | string | `"Edge Gateway Name Format: <Account_Number>-<Region>-<Edge_GW_Identifier>-<edge>"` | yes |
| vdc_group_name | The name of the Data Center Group in VCD | string | `"Data Center Group Name Format: <Account_Number>-<Region>-<Account_Name> <datacenter group>"` | yes |
| ip_sets | A list of IP sets to create in NSX-T | list | `ip_sets = [{name = "Segment-01-Network_192.168.0.0/24_IP-Set", description = "Segment-01 Network IP Set", ip_addresses = ["192.168.0.0/24"]}, {name = "Segment-02-Network_192.168.1.0/24_IP-Set", description = "Segment-02 Network IP Set", ip_addresses = ["192.168.0.0/24"]}]` | yes |
| name | The name of the IP set | string | | yes |
| description | A description of the IP set | string | | yes |
| ip_addresses | A list of IP addresses to include in the IP set | list | | yes |

## Outputs

| Name             | Description                              |
|------------------|------------------------------------------|
| ip_set_names     | The names of the NSX-T IP sets that were created |
| ip_set_ids       | The IDs of the NSX-T IP sets that were created |

## Example Usage

```terraform
module "nsxt_ip_sets" {
  source            = "github.com/global-vmware/vcd_nsxt_ip_set.git?ref=v1.1.0"

  vdc_org_name      = "<VDC-ORG-NAME>"
  vdc_group_name    = "<VDC-GROUP-NAME>"
  vdc_edge_name     = "<NSXT-EDGE-NAME>"

  ip_sets = [
    {
      name         = "US1-Segment-01-Network_192.168.0.0/24_IP-Set"
      description  = "US1-Segment-01 Network IP Set"
      ip_addresses = ["172.16.0.0/24"]
    },
    {
      name         = "US1-Segment-02-Network_192.168.1.0/24_IP-Set"
      description  = "US1-Segment-02 Network IP Set"
      ip_addresses = ["172.16.1.0/24"]
    }
  ]
}
```

