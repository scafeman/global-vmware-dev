output "associated_virtual_service_ids" {
  value = vcd_nsxt_alb_pool.alb-pool.associated_virtual_service_ids
}

output "associated_virtual_services" {
  value = vcd_nsxt_alb_pool.alb-pool.associated_virtual_services
}

output "lb_pool_members" {
  value = [for m in vcd_nsxt_alb_pool.alb-pool.member : {
    enabled    = m.enabled
    ip_address = m.ip_address
    port       = m.port
    ratio      = m.ratio
  }]
  description = "List of all members with their details"
}

output "lb_member_count" {
  value = vcd_nsxt_alb_pool.alb-pool.member_count
}

output "lb_up_member_count" {
  value = vcd_nsxt_alb_pool.alb-pool.up_member_count
}

output "lb_enabled_member_count" {
  value = vcd_nsxt_alb_pool.alb-pool.enabled_member_count
}

output "health_message" {
  value = vcd_nsxt_alb_pool.alb-pool.health_message
}

output "lb_algorithm" {
  value = var.algorithm
}

output "lb_default_server_port" {
  value = var.default_port
}

output "lb_persistence_profile_name" {
  value       = try(vcd_nsxt_alb_pool.alb-pool.persistence_profile[0].name, null)
  description = "System generated name of Persistence Profile"
}

output "lb_health_monitor_type" {
  value       = try(vcd_nsxt_alb_pool.alb-pool.health_monitor[*].type, null)
  description = "Type of health monitor. One of HTTP, HTTPS, TCP, UDP, PING"
}

output "lb_health_monitor_name" {
  value       = try(vcd_nsxt_alb_pool.alb-pool.health_monitor[*].name, null)
  description = "System generated name of Health monitor"
}

output "lb_health_monitor_system_defined" {
  value       = try(vcd_nsxt_alb_pool.alb-pool.health_monitor[*].system_defined, null)
  description = "A boolean flag if the Health monitor is system defined"
}

output "lb_member_group_ipset_name" {
  value = var.member_group_ip_set_name
}