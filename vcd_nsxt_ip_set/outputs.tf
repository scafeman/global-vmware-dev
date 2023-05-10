output "ip_set_names" {
  value = [for set in vcd_nsxt_ip_set.ip_sets : set.name]
}

output "ip_set_ids" {
  value = [for set in vcd_nsxt_ip_set.ip_sets : set.id]
}