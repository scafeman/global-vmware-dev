terraform {
  required_version = ">= 1.2"

  required_providers {
    vcd = {
      source  = "vmware/vcd"
      version = ">= 3.8.2"
    }
  }
}

# Create the Datacenter Group data source
data "vcd_vdc_group" "dcgroup" {
  org   = var.vdc_org_name
  name  = var.vdc_group_name
}

resource "vcd_nsxt_dynamic_security_group" "group" {
  for_each = var.dynamic_security_groups

  org          = var.vdc_org_name
  vdc_group_id = data.vcd_vdc_group.dcgroup.id

  name        = each.key
  description = each.value.description

  dynamic "criteria" {
    for_each = each.value.criteria
    content {
      dynamic "rule" {
        for_each = [criteria.value]
        content {
          type     = rule.value.type
          operator = rule.value.operator
          value    = rule.value.value
        }
      }
    }
  }
}
