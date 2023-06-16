# VCD NSX-T ALB Pool Module

This Terraform module will deploy a NSX-T ALB Pool into an existing VMware Cloud Director (VCD) environment. It can be used to provision a new ALB Pool, which represents a group of servers to which the load balancer can distribute traffic. This module can be used to provsion new ALB Pools into [Rackspace Technology SDDC Flex](https://www.rackspace.com/cloud/private/software-defined-data-center-flex) VCD Data Center Regions.

## Requirements

| Name | Version |
|------|---------|
| terraform | ~> 1.2 |
| vcd | ~> 3.8 |

## Resources

| Name | Type |
|------|------|
| [vcd_vdc_group](https://registry.terraform.io/providers/vmware/vcd/latest/docs/data-sources/vdc_group) | Data Source |
| [vcd_nsxt_edgegateway](https://registry.terraform.io/providers/vmware/vcd/latest/docs/data-sources/nsxt_edgegateway) | Data Source |
| [vcd_library_certificate](https://registry.terraform.io/providers/vmware/vcd/latest/docs/data-sources/library_certificate) | Data Source |
| [vcd_nsxt_ip_set](https://registry.terraform.io/providers/vmware/vcd/latest/docs/data-sources/nsxt_ip_set) | Data Source |
| [vcd_nsxt_alb_pool](https://registry.terraform.io/providers/vmware/vcd/latest/docs/resources/nsxt_alb_pool) | Resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| vdc_org_name | The name of the Data Center Group Organization in VCD | string | `"Organization Name Format: <Account_Number>-<Region>-<Account_Name>"` | yes |
| vdc_group_name | The name of the Data Center Group in VCD | string | `"Data Center Group Name Format: <Account_Number>-<Region>-<Account_Name> <datacenter group>"` | yes |
| vcd_edge_name | Name of the Data Center Group Edge Gateway | string | `"Edge Gateway Name Format: <Account_Number>-<Region>-<Edge_GW_Identifier>-<edge>"` | Yes |
| pool_name | A name for NSX-T ALB Pool | string | - | yes |
| members | List of pool members | list(object({ enabled = bool, ip_address = string, port = number, ratio = number })) | - | yes |
| member_group_id | A reference to NSX-T IP Set | string | "" | no |
| member_group_ip_set_name | The name of the Member Group IP Set | string | "" | no |
| use_member_group | Whether to use an IP set as pool members | bool | false | no |
| description | An optional description NSX-T ALB Pool | string | "" | no |
| enabled | Boolean value if NSX-T ALB Pool should be enabled | bool | true | no |
| algorithm | Optional algorithm for choosing pool members | string | "LEAST_CONNECTIONS" | no |
| default_port | Default Port defines destination server port used by the traffic sent to the member | number | - | yes |
| graceful_timeout_period | Maximum time in minutes to gracefully disable pool member | string | "1" | no |
| passive_monitoring_enabled | Defines if client traffic should be used to check if pool member is up or down | bool | true | no |
| ca_certificate_name | The name of the CA certificate | string | "" | no |
| cn_check_enabled | Specifies whether to check the common name of the certificate presented by the pool member | bool | false | no |
| domain_names | A set of domain names which will be used to verify the common names or subject alternative names presented by the pool member certificates | list(string) | [] | no |
| persistence_profile | Persistence profile to ensure that the same user sticks to the same server for a desired duration of time | list(object({ type = string, value = string })) | - | yes |
| health_monitor | Health monitor to check if a member is up or down | list(object({ type = string, method = string, url = string, interval = number, timeout = number, retries = number, max_retries = number, http_version = string, http_method = string, url_path = string })) | - | yes |

## Outputs

| Name | Description |
|------|-------------|
| associated_virtual_service_ids | The IDs of the Virtual Services associated with the ALB Pool |
| associated_virtual_services | The Virtual Services associated with the ALB Pool |
| member_count | The total count of the members in the ALB Pool |
| up_member_count | The count of the up members in the ALB Pool |
| enabled_member_count | The count of the enabled members in the ALB Pool |
| health_message | The health message for the ALB Pool |
| persistence_profile_name | System generated name of Persistence Profile |
| health_monitor_type | Type of health monitor. One of HTTP, HTTPS, TCP, UDP, PING |
| health_monitor_name | System generated name of Health monitor |
| health_monitor_system_defined | A boolean flag if the Health monitor is system defined |

## Module Usage

Here is an example of how you can use this module in your inventory structure:

```terraform
module "vcd_nsxt_alb_pool" {
  source          = "github.com/global-vmware/vcd_nsxt_alb_pool.git?ref=v1.1.0"
  
  vdc_group_name      = "<US1-VDC-GRP-NAME>"
  vdc_org_name        = "<US1-VDC-ORG-NAME>"
  vdc_edge_name       = "<US1-VDC-EDGE-NAME>"


  pool_name = "prod-app-web-pool"

  default_port = "443"

  members = []

  use_member_group = true
  member_group_ip_set_name = "US1-Prod-App-Web-Pool"

  algorithm = "LEAST_LOAD"

  persistence_profile = [
    {
      type  = "TLS"
      value = ""
    }
  ]

  health_monitor = [
    {
      type = "PING"
    }
  ]

  ca_certificate_name = "US1-domain.com-SSL-Certificate"

  cn_check_enabled = false
  domain_names = []
}
```

## Authors

This module is maintained by the [Global VMware Cloud Automation Services Team](https://github.com/global-vmware).