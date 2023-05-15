# VCD Security Tag Terraform Module

This Terraform module allows you to create Security Tags and associate them with Virtual Machines (VMs) in an existing VMware Cloud Director (VCD) Environment.  This module can be used to provsion new Security Tags into [Rackspace Technology SDDC Flex](https://www.rackspace.com/cloud/private/software-defined-data-center-flex) VCD Data Center Regions.

## Requirements

| Name      | Version |
|-----------|---------|
| terraform | >= 1.2  |
| vcd       | >= 3.8.2 |

## Resources

| Name                                                      | Type         |
|-----------------------------------------------------------|--------------|
| [vcd_security_tag](https://registry.terraform.io/providers/vmware/vcd/latest/docs/resources/security_tag) | Resource |
| [vcd_vm](https://registry.terraform.io/providers/vmware/vcd/latest/docs/data-sources/vm) | Data Source |

## Inputs

| Name              | Description                                                      | Type                      | Default | Required |
|-------------------|------------------------------------------------------------------|---------------------------|---------|----------|
| `vdc_org_name` | The name of the organization in VCD | string | `"Organization Name Format: <Account_Number>-<Region>-<Account_Name>"` | yes | 
| `security_tags` | Map of security tags and their corresponding VM names | map(list(string)) | `{"pd-app-web" = ["Prod App Web Server 01", "Prod App Web Server 02"]}` | no |
| `vm_names` | List of VM names that the security tag is going to be applied to | list(string) | `["Prod App Web Server 01", "Prod App Web Server 02"]` | no |


## Outputs

| Name              | Description                              |
|-------------------|------------------------------------------|
| `tag_vm_mapping`  | Mapping of security tags and associated VM names. The output is a map where the keys are the tag names and the values are the associated VM names. |

## Example Usage

This is an example of a `main.tf` file that uses the VCD Security Tag Terraform Module to create security tags and associate them with VMs in VMware Cloud Director:

```terraform
module "vcd_security_tags" {
  source            = "github.com/global-vmware/vcd_security_tag.git?ref=v1.1.0"
  
  vdc_org_name      = "<VDC-ORG-NAME>"

  security_tags = {
    "pd-app-web"    = ["Prod App Web Server 01", "Prod App Web Server 02"]
  }
  
  vm_names          = ["Prod App Web Server 01", "Prod App Web Server 02"]
}
```

## Authors

This module is maintained by the [Global VMware Cloud Automation Services Team](https://github.com/global-vmware).
