terraform {
  required_version = "~> 1.2"

  required_providers {
    vcd = {
      source  = "vmware/vcd"
      version = "~> 3.8"
    }
  }
}

data "vcd_vdc_group" "vdc_group" {
  name = var.vdc_group_name
}

data "vcd_nsxt_edgegateway" "edge_gateway" {
  org             = var.vdc_org_name
  owner_id        = data.vcd_vdc_group.vdc_group.id
  name            = var.vdc_edge_name
}

data "vcd_network_routed_v2" "org_vdc_routed_network" {
  for_each        = { for net in var.org_network_names : net.name => net }

  org             = var.vdc_org_name
  edge_gateway_id = data.vcd_nsxt_edgegateway.edge_gateway.id
  name            = each.value.name
  
}

resource "vcd_nsxt_security_group" "security_group" {
  for_each        = var.security_groups

  org             = var.vdc_org_name
  edge_gateway_id = data.vcd_nsxt_edgegateway.edge_gateway.id
  name            = each.key
  description     = each.value.description
  
  member_org_network_ids = [
    for org_network_name in each.value.org_network_names :
    data.vcd_network_routed_v2.org_vdc_routed_network[org_network_name].id
  ]
}
