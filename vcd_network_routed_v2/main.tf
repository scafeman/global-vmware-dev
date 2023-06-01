terraform {
  required_version = "~> 1.2"

  required_providers {
    vcd = {
      source  = "vmware/vcd"
      version = "~> 3.8"
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

#########################
# Org VDC Routed Network
######################### 

resource "vcd_network_routed_v2" "org_vdc_routed_network" {
  for_each        = var.segments
  org             = var.vdc_org_name
  name            = each.key
  edge_gateway_id = data.vcd_nsxt_edgegateway.t1.id

  gateway         = each.value.gateway
  prefix_length   = each.value.prefix_length
  dns1            = each.value.dns1
  dns2            = each.value.dns2
  dns_suffix      = each.value.dns_suffix

  static_ip_pool {
    start_address = each.value.start_address
    end_address   = each.value.end_address
  }
}
