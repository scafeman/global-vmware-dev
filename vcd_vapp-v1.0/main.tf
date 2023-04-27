terraform {
  required_version = ">= 1.2"

  required_providers {
    vcd = {
      source = "vmware/vcd"
      version = "3.8.2"
    }
  }
}

data "vcd_vdc_group" "vdc_group" {
  name = var.vdc_group_name
}

resource "vcd_vapp" "vapp" {
  for_each = { for name in var.vapp_names: name => {} }
  name     = each.key
  org      = var.vdc_org_name
  vdc      = var.vdc_name
}
