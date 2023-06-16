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

output "persistence_profile_name" {
  value = vcd_nsxt_alb_pool.alb-pool.persistence_profile[0].name
  description = "System generated name of Persistence Profile"
}

output "health_monitor_type" {
  value = vcd_nsxt_alb_pool.alb-pool.health_monitor[*].type
  description = "Type of health monitor. One of HTTP, HTTPS, TCP, UDP, PING"
}

output "health_monitor_name" {
  value = vcd_nsxt_alb_pool.alb-pool.health_monitor[*].name
  description = "System generated name of Health monitor"
}

output "health_monitor_system_defined" {
  value = vcd_nsxt_alb_pool.alb-pool.health_monitor[*].system_defined
  description = "A boolean flag if the Health monitor is system defined"
}