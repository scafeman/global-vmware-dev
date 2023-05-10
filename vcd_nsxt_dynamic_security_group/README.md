# VCD NSX-T Dynamic Security Group Terraform Module

This Terraform module manages NSX-T Dynamic Security Groups in VMware Cloud Director (VCD) environments using the `vmware/vcd` provider.

## Requirements

| Name      | Version |
|-----------|---------|
| terraform | >= 1.2  |
| vcd       | >= 3.8.2 |

## Resources

| Name                                                                 | Type         |
|----------------------------------------------------------------------|--------------|
| [vcd_vdc_group](https://registry.terraform.io/providers/vmware/vcd/3.8.2/docs/data-sources/vdc_group) | data source |
| [vcd_nsxt_dynamic_security_group](https://registry.terraform.io/providers/vmware/vcd/3.8.2/docs/resources/nsxt_dynamic_security_group) | resource |

## Inputs

| Name            | Description                                                      | Type | Default | Required |
|-----------------|------------------------------------------------------------------|------|---------|----------|
| `vdc_org_name` | The name of the Data Center Group Organization in VCD | string | n/a | yes |
| `vdc_group_name` | The name of the Data Center Group in VCD | string | n/a | yes |
| `dynamic_security_groups` | A map of dynamic security groups to create in NSX-T. Each element of the map should contain a `description` field and a `criteria` list field, where each item in the `criteria` list should be a map containing `type`, `operator`, and `value` fields. | map(object({ description = string, criteria = list(any) })) | n/a | yes |

## Outputs

| Name             | Description                              |
|------------------|------------------------------------------|
| `dynamic_security_groups` | Information about the created NSX-T dynamic security groups. The output is a map where the keys are the names of the dynamic security groups and the values are maps with the following fields: `id`, `name`, `description`, and `member_vms`. |

## Example Usage

This is an example of a `main.tf` file that uses the `"github.com/global-vmware/vcd_nsxt_dynamic_security_group"` Module source to create NSX-T dynamic security groups in a VMware Cloud Director environment:

```terraform
module "vcd_nsxt_dynamic_security_group" {
  source            = "github.com/global-vmware/vcd_nsxt_dynamic_security_group.git?ref=v1.0.0"

  vdc_org_name      = "<VDC-ORG-NAME>"
  vdc_group_name    = "<VDC-GROUP-NAME>"

  dynamic_security_groups = {
    Web-Servers_Dynamic-SG = {
      description = "Web Servers Dynamic Security Group"
      criteria    = [
        {
          type     = "VM_TAG"
          operator = "EQUALS"
          value    = "web"
        }
      ]
    },
    Database-Servers_Dynamic-SG = {
      description = "Database Servers Dynamic Security Group"
      criteria    = [
        {
          type     = "VM_TAG"
          operator = "EQUALS"
          value    = "db"
        }
      ]
    }
  }
}
```

## Authors

This module is maintained by the [Global VMware Cloud Automation Services Team](https://github.com/global-vmware).
