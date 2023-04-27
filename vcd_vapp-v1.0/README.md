## Virtual Application VM Terraform Module
This Terraform module will deploy a vApp and "X" number of Virtual Machines into an existing VMware Cloud Director (VCD) Environment.  This module can be used to provsion a new vApp and Virtual Machines into Rackspace Technology SDDC Flex VCD Data Center Regions.

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.2 |
| vcd | >= 3.8.2 |

## Resources

| Name | Type |
|------|------|
| [vcd_vapp_vm](https://registry.terraform.io/providers/vmware/vcd/3.8.2/docs/resources/vapp_vm) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| vdc_org_name | Name of the Data Center Group Organization | string | `"Data Center Group Name Format: <Account_Number>-<Region>-<Account_Name>"` | Yes |
| vdc_group_name | Name of the Data Center Group | string | `"Data Center Group Name Format: <Account_Number>-<Region>-<Account_Name> <datacenter group>"` | Yes |
| vdc_name | Cloud Director VDC Name | string | `"Virtual Data Center Name Format: <Account_Number>-<Region>-<Segment Name>"` | Yes |

## Outputs

| Name | Description |
|------|-------------|
| vm_names | An array of formatted VM names. |


## Example Usage
This is an example of a main.tf file that would use the "github.com/global-vmware/vcd_vapp_vm" Module Source to create a Virtual Application and it's associated Virtual Machines.

The Terraform code example for the main.tf file is below:

```terraform
module "vcd_vapp_vm" {
  source                            = "github.com/global-vmware/vcd_vapp_vm.git?ref=v1.4.0"
  
  vdc_org_name                      = "<US1-VDC-ORG-NAME>"
  vdc_group_name                    = "<US1-VDC-GRP-NAME>"
  vdc_name                          = "<US1-VDC-NAME>"
  vcd_edgegateway_name              = "<US1-VDC-EDGE-NAME>"
  catalog_name                      = "<US1-CATALOG-NAME>"
  catalog_template_name             = "Ubuntu 22.04"
  vapp_org_network_name             = "US1-Segment-01"
  network_cidr                      = "172.16.0.0/24"
  network_ip_allocation_mode        = "MANUAL"

  vm_count                          = 2
  vm_sizing_policy_name             = "gp4.8"

  vapp_name                         = "My Production Application"
  vm_name_environment               = "Prod"
  vm_app_name                       = "App"
  vm_app_role                       = "Web Server"
  vm_computer_name_environment      = "pd"
  vm_computer_name_app_name         = "app"
  vm_computer_name_role             = "web"

  vm_metadata_entries = [
    {
      key         = "Cost Center"
      value       = "IT Department - 1001"
      type        = "MetadataStringValue"
      user_access = "READWRITE"
      is_system   = false
    },
    {
      key         = "Operating System"
      value       = "Ubuntu Linux (64-Bit)"
      type        = "MetadataStringValue"
      user_access = "READWRITE"
      is_system   = false
    },
    {
      key         = "Server Role"
      value       = "Web Server"
      type        = "MetadataStringValue"
      user_access = "READWRITE"
      is_system   = false
    },
    {
      key         = "Build Date"
      value       = timestamp()
      type        = "MetadataDateTimeValue"
      user_access = "READWRITE"
      is_system   = false
    },
    {
      key         = "Built By"
      value       = "Build Engineering Team"
      type        = "MetadataStringValue"
      user_access = "READWRITE"
      is_system   = false
    }    
  ]
}
```