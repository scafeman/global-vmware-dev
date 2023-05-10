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
  name = var.vdc_group_name
}

# Create the NSX-T Edge Gateway data source
data "vcd_nsxt_edgegateway" "t1" {
  org      = var.vdc_org_name
  owner_id = data.vcd_vdc_group.dcgroup.id
  name     = var.vdc_edge_name
}

# Create the vcd_nsxt_ip_set resource to manage NSX-T IP sets
resource "vcd_nsxt_ip_set" "ip_sets" {
  for_each        = { for set in var.ip_sets : set.name => set }
  org             = var.vdc_org_name
  edge_gateway_id = data.vcd_nsxt_edgegateway.t1.id
  name            = each.value.name
  description     = each.value.description
  ip_addresses    = each.value.ip_addresses
}
