# VCD Security Tag Terraform Module

This Terraform module allows you to create security tags and associate them with virtual machines (VMs) in VMware Cloud Director (VCD).

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
| `vdc_org_name`    | The name of the organization in VCD | string | | yes |
| `security_tags`   | List of security tags and their corresponding VM names | map(list(string)) | {} | yes |
| `vm_names`        | List of VM names that the security tag is going to be applied to | list(string) | [] | yes |

## Outputs

| Name              | Description                              |
|-------------------|------------------------------------------|
| `tag_vm_mapping`  | Mapping of security tags and associated VM names. The output is a map where the keys are the tag names and the values are the associated VM names. |

## Example Usage

This is an example of a `main.tf` file that uses the VCD Security Tag Terraform Module to create security tags and associate them with VMs in VMware Cloud Director:

```terraform
module "vcd_security_tags" {
  source             = "github.com/global-vmware/vcd_security_tag.git?ref=v1.1.0"
  
  vdc_org_name      = "<VDC-ORG-NAME>"

  security_tags = {
    "pd-app-web"    = ["Prod App Web Server 01", "Prod App Web Server 02"]
    "pd-app-db"     = ["Prod App DB Server 01", "Prod App DB Server 02"]
  }
  
  vm_names = ["Prod App Web Server 01", "Prod App Web Server 02", "Prod App DB Server 01", "Prod App DB Server 02"]
}
```
