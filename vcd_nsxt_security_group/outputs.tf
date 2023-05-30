output "vdc_group_id" {
  value = data.vcd_vdc_group.vdc_group.id
}

output "edge_gateway_id" {
  value = data.vcd_nsxt_edgegateway.edge_gateway.id
}

output "org_vdc_routed_network_ids" {
  value = {
    for net in var.org_network_names :
    net.name => data.vcd_network_routed_v2.org_vdc_routed_network[net.name].id
  }
}

output "security_group_ids" {
  value = {
    for group_name, group in var.security_groups :
    group_name => {
      id                    = vcd_nsxt_security_group.security_group[group_name].id
      member_vms            = [
        for vm in vcd_nsxt_security_group.security_group[group_name].member_vms :
        vm.vm_name
      ]
      member_org_network_ids = vcd_nsxt_security_group.security_group[group_name].member_org_network_ids
    }
  }
}
