output "ipsec_vpn_tunnel_name" {
  value     = vcd_nsxt_ipsec_vpn_tunnel.tunnel.name
}

output "authentication_mode" {
  value     = vcd_nsxt_ipsec_vpn_tunnel.tunnel.authentication_mode
}

output "local_ip_address" {
  value     = vcd_nsxt_ipsec_vpn_tunnel.tunnel.local_ip_address
}

output "local_networks" {
  value     = vcd_nsxt_ipsec_vpn_tunnel.tunnel.local_networks
}

output "remote_ip_address" {
  value     = vcd_nsxt_ipsec_vpn_tunnel.tunnel.remote_ip_address
}

output "remote_networks" {
  value     = vcd_nsxt_ipsec_vpn_tunnel.tunnel.remote_networks
}

output "remote_id" {
  value     = vcd_nsxt_ipsec_vpn_tunnel.tunnel.remote_id
}

output "security_profile" {
  value     = vcd_nsxt_ipsec_vpn_tunnel.tunnel.security_profile
}

output "status" {
  value     = vcd_nsxt_ipsec_vpn_tunnel.tunnel.status
}
