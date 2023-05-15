terraform {
  required_version = ">= 1.2"

  required_providers {
    vcd = {
      source  = "vmware/vcd"
      version = ">= 3.8.2"
    }
  }
}

resource "vcd_security_tag" "security_tags" {
  for_each = var.security_tags

  name   = each.key
  vm_ids = [for vm_name in each.value : data.vcd_vm.vm[vm_name].id]
}

data "vcd_vm" "vm" {
  for_each = toset(flatten(values(var.security_tags)))

  name = each.value
}
