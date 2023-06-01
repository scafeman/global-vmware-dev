# Terraform VMware Cloud Director Security Group Module

This Terraform module will deploy NSX-T Edge Gateway Firewall Rules in an existing VMware Cloud Director (VCD) environment. This module can be used to provsion new Edge Gateway Firewall Rules into [Rackspace Technology SDDC Flex](https://www.rackspace.com/cloud/private/software-defined-data-center-flex) VCD Data Center Regions.

## Requirements

| Name | Version |
|------|---------|
| terraform | ~> 1.2 |
| vcd | ~> 3.8 |

## Resources

| Name                                                                 | Type         |
|----------------------------------------------------------------------|--------------|
| [vcd_nsxt_edgegateway](https://registry.terraform.io/providers/vmware/vcd/latest/docs/data-sources/nsxt_edgegateway) | Data Source |
| [vcd_vdc_group](https://registry.terraform.io/providers/vmware/vcd/latest/docs/data-sources/vdc_group)| Data Source |
| [vcd_nsxt_security_group](https://registry.terraform.io/providers/vmware/vcd/latest/docs/resources/nsxt_security_group) | Data Source |
| [vcd_nsxt_firewall](https://registry.terraform.io/providers/vmware/vcd/latest/docs/resources/nsxt_firewall) | Resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| vdc_org_name | The name of the Data Center Group Organization in VCD | string | - | yes |
| vdc_group_name | The name of the Data Center Group in VCD | string | - | yes |
| vdc_edge_name | Name of the Data Center Group Edge Gateway | string | - | yes |
| app_port_profiles | Map of app port profiles with their corresponding scopes | map(string) | {} | no |
| ip_set_names | List of IP set names | list(string) | [] | no |
| dynamic_security_group_names | List of dynamic security group names | list(string) | [] | no |
| security_group_names | List of security group names | list(string) | [] | no |
| rules | List of rules to apply | list(object({ name = string, direction = string, ip_protocol = string, action = string, enabled = optional(bool), logging = optional(bool), source_ids = optional(list(string)), destination_ids = optional(list(string)), app_port_profile_ids = optional(list(string)) })) | [] | no |

## Outputs

| Name | Description |
|------|-------------|
| firewall_id | The ID of the firewall |
| firewall_rule_names | The names of the firewall rules |

## Example Usage

```terraform
module "vcd_nsxt_security_group" {
  source = "github.com/global-vmware/vcd_nsxt_security_group.git?ref=v1.2.0"

  vdc_org_name          = "<VDC-ORG-NAME>"
  vdc_group_name        = "<VDC-GRP-NAME>"
  vdc_edge_name         = "<VDC-EDGE-NAME>"

  app_port_profiles = {
  "HTTP"        = "SYSTEM",
  "HTTPS"       = "SYSTEM",
  "MS-SQL-S"    = "SYSTEM",
  "MySQL"       = "SYSTEM",
  "RDP"         = "SYSTEM",
  "SSH"         = "SYSTEM",
  "ICMP ALL"    = "SYSTEM"
  }

  ip_set_names = [
  "US1-Segment-01-Network_172.16.0.0/24_IP-Set",
  "US1-Segment-02-Network_172.16.1.0/24_IP-Set",
  "US1-Segment-03-Network_172.16.2.0/24_IP-Set",
  "US1-Segment-04-Network_172.16.3.0/24_IP-Set",
  "US1-Segment-05-Network_172.16.4.0/24_IP-Set"
  ]

  dynamic_security_group_names = ["DynGroup1", "DynGroup2"]

  security_group_names = ["Group1", "Group2"]

  rules = [
    {
      name                 = "Rule1"
      direction            = "Inbound"
      ip_protocol          = "TCP"
      action               = "Allow"
      enabled              = true
      logging              = false
      source_ids           = ["Group1", "DynGroup1"]
      destination_ids      = ["Group2", "DynGroup2"]
      app_port_profile_ids = ["Profile1", "Profile2"]
    },
    {
      name                 = "Rule2"
      direction            = "Outbound"
      ip_protocol          = "UDP"
      action               = "Deny"
      enabled              = true
      logging              = true
      source_ids           = []
      destination_ids      = []
      app_port_profile_ids = []
    }
  ]
}
```

## Authors

This module is maintained by the [Global VMware Cloud Automation Services Team](https://github.com/global-vmware).