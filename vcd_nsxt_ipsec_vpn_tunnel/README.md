# Terraform VMware Cloud Director NSX-T IPSec VPN Tunnel Module

This Terraform module will deploy an IPSec VPN Tunnel on an NSX-T Edge Gateway in a VMware Cloud Director (VCD) environment. This module can be used to provsion a new IPSec VPN Tunnel into [Rackspace Technology SDDC Flex](https://www.rackspace.com/cloud/private/software-defined-data-center-flex) VCD Data Center Regions.

## Requirements

| Name      | Version |
|-----------|---------|
| terraform | ~> 1.2  |
| vcd       | ~> 3.8  |

## Resources

| Name | Type |
|------|------|
| [vcd_vdc_group](https://registry.terraform.io/providers/vmware/vcd/latest/docs/data-sources/vdc_group) | Data Source |
| [vcd_nsxt_edgegateway](https://registry.terraform.io/providers/vmware/vcd/latest/docs/data-sources/nsxt_edgegateway) | Data Source |
| [vcd_library_certificate](https://registry.terraform.io/providers/vmware/vcd/latest/docs/data-sources/library_certificate) | Data Source |
| [vcd_nsxt_ipsec_vpn_tunnel](https://registry.terraform.io/providers/vmware/vcd/latest/docs/resources/nsxt_ipsec_vpn_tunnel) | Resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| vdc_org_name | The name of the Data Center Group Organization in VCD | string | - | yes |
| vdc_group_name | The name of the Data Center Group in VCD | string | - | yes |
| vdc_edge_name | Name of the Data Center Group Edge Gateway | string | - | yes |
| name | The name of the IPSec VPN tunnel | string | - | yes |
| description | The description of the IPSec VPN tunnel | string | "" | no |
| enabled | Whether the IPSec VPN tunnel is enabled | bool | true | no |
| pre_shared_key | The pre-shared key for authentication (used when authentication mode is PSK) | string | "" | no |
| local_ip_address | The local IP address for the IPSec VPN tunnel | string | - | yes |
| local_networks | List of local networks (CIDR blocks) to be included in the tunnel | list(string) | - | yes |
| remote_ip_address | The remote IP address for the IPSec VPN tunnel | string | - | yes |
| remote_id | The remote identifier for the IPSec VPN tunnel | string | - | yes |
| remote_networks | List of remote networks (CIDR blocks) to be included in the tunnel | list(string) | ["0.0.0.0/0"] | no |
| logging | Whether logging is enabled for the IPSec VPN tunnel | bool | false | no |
| authentication_mode | The authentication mode for the IPSec VPN tunnel | string | "PSK" | no |
| certificate_alias | The alias of the library certificate to use for authentication | string | "" | no |
| ca_certificate_alias | The alias of the CA certificate to use for authentication | string | "" | no |
| certificate_id | The ID of the library certificate to use for authentication | string | "" | no |
| ca_certificate_id | The ID of the CA certificate to use for authentication | string | "" | no |

## Outputs

| Name                  | Description                                      |
|-----------------------|--------------------------------------------------|
| ipsec_vpn_tunnel_name | The name of the IPSec VPN tunnel                  |
| authentication_mode   | The authentication mode of the IPSec VPN tunnel   |
| local_ip_address      | The local IP address of the IPSec VPN tunnel      |
| local_networks        | The local networks of the IPSec VPN tunnel        |
| remote_ip_address     | The remote IP address of the IPSec VPN tunnel     |
| remote_networks       | The remote networks of the IPSec VPN tunnel       |
| remote_id             | The remote identifier of the IPSec VPN tunnel     |
| security_profile      | The security profile of the IPSec VPN tunnel      |
| status                | The status of the IPSec VPN tunnel                |

## Example Usage

```terraform
module "vcd_nsxt_ipsec_vpn_tunnel" {
  source                = "github.com/global-vmware/vcd_nsxt_ipsec_vpn_tunnel.git?ref=v1.1.0"

  vdc_org_name          = "<US1-VDC-ORG-NAME>"
  vdc_group_name        = "<US1-VDC-GRP-NAME>"
  vdc_edge_name         = "<US1-VDC-EDGE-NAME>"

  name                  = "US1-VPN-Tunnel-->US2"

  authentication_mode   = "PSK"

  pre_shared_key        = "mysecretpsk"

  local_ip_address      = "8.8.8.8"
  local_networks        = ["172.16.0.0/24", "172.16.1.0/24", "172.16.2.0/24", "172.16.3.0/24", "172.16.4.0/24"]

  remote_ip_address     = "9.9.9.9"
  remote_networks       = ["172.16.10.0/24", "172.16.11.0/24", "172.16.12.0/24", "172.16.13.0/24", "172.16.14.0/24"]
}
```

## Authors

This module is maintained by the [Global VMware Cloud Automation Services Team](https://github.com/global-vmware).
