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
| vdc_org_name | The name of the Data Center Group Organization in VCD | string | | yes |
| vdc_edge_name | The name of the NSX-T Edge Gateway in VCD | string | | yes |
| vdc_group_name | The name of the Data Center Group in VCD | string | | yes |
| ip_sets | A list of IP sets to create in NSX-T | list | | yes |
| ip_sets.name | The name of the IP set | string | | yes |
| ip_sets.description | A description of the IP set | string | | yes |
| ip_sets.ip_addresses | A list of IP addresses to include in the IP set | list | | yes |

## Outputs

| Name             | Description                              |
|------------------|------------------------------------------|
| ip_set_names     | The names of the NSX-T IP sets that were created |
| ip_set_ids       | The IDs of the NSX-T IP sets that were created |

## Example Usage

```terraform
module "nsxt_ip_sets" {
  source = "github.com/example/terraform-vcd-nsxt-ip-sets"

  vdc_org_name   = "my-org-name"
  vdc_edge_name  = "my-edge-name"
  vdc_group_name = "my-group-name"

  ip_sets = [
    {
      name         = "my-ip-set-1"
      description  = "My first IP set"
      ip_addresses = ["192.168.0.0/24", "10.0.0.0/16"]
    },
    {
      name         = "my-ip-set-2"
      description  = "My second IP set"
      ip_addresses = ["172.16.0.0/16"]
    }
  ]
}

output "nsxt_ip_set_names" {
  value = module.nsxt_ip_sets.ip_set_names
}

output "nsxt_ip_set_ids" {
  value = module.nsxt_ip_sets.ip_set_ids
}
