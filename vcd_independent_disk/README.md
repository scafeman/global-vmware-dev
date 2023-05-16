# VCD Independent Disk Terraform Module

This Terraform module will deploy VCD Independent Disks into an existing VMware Cloud Director (VCD) Environment.  This module can be used to provsion new Independent Disks into [Rackspace Technology SDDC Flex](https://www.rackspace.com/cloud/private/software-defined-data-center-flex) VCD Data Center Regions.

## Requirements

| Name      | Version |
|-----------|---------|
| terraform | ~> 1.2  |
| vcd       | ~> 3.8  |

## Resources

| Name                                                                 | Type         |
|----------------------------------------------------------------------|--------------|
| [vcd_independent_disk](https://registry.terraform.io/providers/vmware/vcd/latest/docs/resources/independent_disk) | resource |

## Inputs

| Name            | Description                                                      | Type | Default | Required |
|-----------------|------------------------------------------------------------------|------|---------|----------|
| `vdc_org_name` | The name of the Organization in VCD | string | `"Organization Name Format: <Account_Number>-<Region>-<Account_Name>"` | yes |
| `disk_params` | A list of maps containing disk parameters. Each map item describes a single disk. | list(object({ name = string, size_in_mb = string, bus_type = string, bus_sub_type = string, storage_profile = string, sharing_type = string, metadata = list(object({ key = string, value = string, type = string, user_access = string, is_system = bool })) })) | `[{name = "DataDisk01", size_in_mb = "102400", bus_type = "SCSI", bus_sub_type = "lsilogicsas", storage_profile = "Standard", sharing_type = "None", metadata = []}, {name = "DataDisk02", size_in_mb = "204800", bus_type = "SCSI", bus_sub_type = "lsilogicsas", storage_profile = "Performance", sharing_type = "None", metadata = []}]` | no |

## Outputs

| Name             | Description                              |
|------------------|------------------------------------------|
| `independent_disks` | Information about the created independent disks. The output is a map where the keys are the disk IDs and the values are maps with the following fields: `name`, `size_in_mb`, `bus_type`, `bus_sub_type`, `storage_profile`, `sharing_type`, `description`, `metadata`, and `is_attached`. |

## Example Usage

This is an example of a `main.tf` file that uses the `"github.com/global-vmware/vcd_independent_disk"` Module source to create independent disks in a VMware Cloud Director environment:

```terraform
module "vcd_independent_disk" {
  source            = "github.com/global-vmware/vcd_independent_disk.git?ref=v1.1.0"

  vdc_org_name      = "<US1-VDC-ORG-NAME>"

  disk_params       = [
    {
      name              = "Prod App Web 01-WebDataDisk01"
      size_in_mb        = "102400"
      bus_type          = "SCSI"
      bus_sub_type      = "lsilogicsas"
      storage_profile   = "Standard"
      sharing_type      = "None"
      metadata          = [
        {
          key         = "Built By"
          value       = "Terraform"
          type        = "MetadataStringValue"
          user_access = "READWRITE"
          is_system   = false
        },
        {
          key         = "Cost Center"
          value       = "IT Department - 1001"
          type        = "MetadataStringValue"
          user_access = "READWRITE"
          is_system   = false
        }
      ]
    },
    // More disks can be added here
  ]
}
```

## Authors

This module is maintained by the [Global VMware Cloud Automation Services Team](https://github.com/global-vmware).