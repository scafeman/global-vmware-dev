# VCD NSX-T Distributed Firewall Rules Terraform Module

This Terraform module deploys NSX-T Distributed Firewall Rules into an existing VMware Cloud Director (VCD) environment. It enables the provisioning of new Distributed Firewall Rules into [Rackspace Technology SDDC Flex](https://www.rackspace.com/cloud/private/software-defined-data-center-flex) VCD Data Center Regions.

## Requirements

| Name | Version |
|------|---------|
| terraform | ~> 1.2 |
| vcd | ~> 3.8 |

## Resources

| Name | Type |
|------|------|
| [vcd_nsxt_edgegateway](https://registry.terraform.io/providers/vmware/vcd/latest/docs/data-sources/nsxt_edgegateway) | Data Source |
| [vcd_vdc_group](https://registry.terraform.io/providers/vmware/vcd/latest/docs/data-sources/vdc_group) | Data Source |
| [vcd_nsxt_security_group](https://registry.terraform.io/providers/vmware/vcd/latest/docs/resources/nsxt_security_group) | Data Source |
| [vcd_nsxt_distributed_firewall](https://registry.terraform.io/providers/vmware/vcd/latest/docs/resources/nsxt_distributed_firewall) | Resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| vdc_org_name | The name of the Data Center Group Organization in VCD | string | - | yes |
| vdc_group_name | The name of the Data Center Group in VCD | string | - | yes |
| vdc_edge_name | Name of the Data Center Group Edge Gateway | string | - | yes |
| app_port_profiles | Map of app port profiles with their corresponding scopes | map(string) | {} | no |
| ip_set_names | List of IP set names | list(string) | [] | yes |
| dynamic_security_group_names | List of dynamic security group names | list(string) | [] | no |
| security_group_names | List of security group names | list(string) | [] | no |
| rules | List of rules to apply | list(object({ name = string, direction = string, ip_protocol = string, action = string, enabled = optional(bool), logging = optional(bool), source_ids = optional(list(string)), destination_ids = optional(list(string)), app_port_profile_ids = optional(list(string)) })) | [] | yes |

## Outputs

| Name | Description |
|------|-------------|
| firewall_id | The ID of the firewall |
| firewall_rule_names | The names of the firewall rules |

## Example Usage

```terraform
module "vcd_nsxt_distributed_firewall" {
  source = "github.com/global-vmware/vcd_nsxt_distributed_firewall.git?ref=v1.1.0"

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
    "US1-Segment-05-Network_172.16.4.0/24_IP-Set",
    "Default_IP_SET_10.0.2.0/24",
    "US1-NSXT-ALB_Service"
  ]

  dynamic_security_group_names = [
    "Prod-App-Web_Dynamic-SG",
    "Prod-App-DB_Dynamic-SG"
  ]

  rules = [
    {
      name                  = "Allow_Prod-App-Web-->Prod-App-DB"
      direction             = "IN_OUT"
      ip_protocol           = "IPV4"
      action                = "ALLOW"
      app_port_profile_ids  = ["MS-SQL-S"]
      source_ids            = ["Prod-App-Web_Dynamic-SG"]
      destination_ids       = ["Prod-App-DB_Dynamic-SG"]
    },
    {
      name                  = "Allow_US1-NSXT-ALB-->Prod-App-Web"
      direction             = "IN_OUT"
      ip_protocol           = "IPV4"
      action                = "ALLOW"
      app_port_profile_ids  = ["HTTPS"]
      source_ids            = ["US1-NSXT-ALB_Service"]
      destination_ids       = ["Prod-App-Web_Dynamic-SG"]
    },
    {
      name                  = "Allow_US1-Segment-03-->US1-Segment-01"
      direction             = "IN_OUT"
      ip_protocol           = "IPV4"
      action                = "ALLOW"
      app_port_profile_ids  = ["SSH", "RDP", "HTTP", "HTTPS"]
      source_ids            = ["US1-Segment-03-Network_172.16.2.0/24_IP-Set"]
      destination_ids       = ["US1-Segment-01-Network_172.16.0.0/24_IP-Set"]
    },
    {
      name                  = "Allow_US1-Segment03-->US1-Segment-04"
      direction             = "IN_OUT"
      ip_protocol           = "IPV4"
      action                = "ALLOW"
      app_port_profile_ids  = ["HTTP", "HTTPS", "MS-SQL-S", "MySQL"]
      source_ids            = ["US1-Segment-03-Network_172.16.2.0/24_IP-Set"]
      destination_ids       = ["US1-Segment-04-Network_172.16.3.0/24_IP-Set"]
    },
    {
      name                  = "Allow_ICMP-ALL"
      direction             = "IN_OUT"
      ip_protocol           = "IPV4"
      action                = "ALLOW"
      app_port_profile_ids  = ["ICMP ALL"]
    },
    {
      name                  = "Allow_Outbound-Internet"
      direction             = "IN_OUT"
      ip_protocol           = "IPV4"
      action                = "ALLOW"
      source_ids            = [
        "US1-Segment-01-Network_172.16.0.0/24_IP-Set",
        "US1-Segment-02-Network_172.16.1.0/24_IP-Set",
        "US1-Segment-03-Network_172.16.2.0/24_IP-Set",
        "US1-Segment-04-Network_172.16.3.0/24_IP-Set",
        "US1-Segment-05-Network_172.16.4.0/24_IP-Set",
        "Default_IP_SET_10.0.2.0/24"
      ]
    },
    {
      name                  = "Default_Drop"
      direction             = "IN_OUT"
      ip_protocol           = "IPV4"
      action                = "DROP"
    }
  ]
}
```

## Authors

This module is maintained by the [Global VMware Cloud Automation Services Team](https://github.com/global-vmware).