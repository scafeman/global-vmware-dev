output "firewall_id" {
  description = "The ID of the firewall"
  value       = vcd_nsxt_distributed_firewall.nsxt_dfw.id
}

output "firewall_rule_names" {
  description = "The names of the firewall rules"
  value       = [for r in vcd_nsxt_distributed_firewall.nsxt_dfw.rule: r.name]
}
