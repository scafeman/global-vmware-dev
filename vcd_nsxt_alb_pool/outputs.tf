output "associated_virtual_service_ids" {
  value = vcd_nsxt_alb_pool.alb-pool.associated_virtual_service_ids
}

output "associated_virtual_services" {
  value = vcd_nsxt_alb_pool.alb-pool.associated_virtual_services
}

output "member_count" {
  value = vcd_nsxt_alb_pool.alb-pool.member_count
}

output "up_member_count" {
  value = vcd_nsxt_alb_pool.alb-pool.up_member_count
}

output "enabled_member_count" {
  value = vcd_nsxt_alb_pool.alb-pool.enabled_member_count
}

output "health_message" {
  value = vcd_nsxt_alb_pool.alb-pool.health_message
}
