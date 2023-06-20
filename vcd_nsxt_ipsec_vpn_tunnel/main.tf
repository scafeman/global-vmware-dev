terraform {
  required_version = "~> 1.2"

  required_providers {
    vcd = {
      source  = "vmware/vcd"
      version = "~> 3.8"
    }
  }
}

data "vcd_vdc_group" "dcgroup" {
  name  = var.vdc_group_name
}

data "vcd_nsxt_edgegateway" "edge_gateway" {
  org      = var.vdc_org_name
  owner_id = data.vcd_vdc_group.dcgroup.id
  name     = var.vdc_edge_name
}

data "vcd_library_certificate" "cert" {
  count = var.authentication_mode == "CERTIFICATE" ? 1 : 0
  alias = var.certificate_alias
}

data "vcd_library_certificate" "ca-cert" {
  count = var.authentication_mode == "CERTIFICATE" ? 1 : 0
  alias = var.ca_certificate_alias
}

resource "vcd_nsxt_ipsec_vpn_tunnel" "tunnel" {
  edge_gateway_id = data.vcd_nsxt_edgegateway.edge_gateway.id

  name              = var.name
  description       = var.description
  enabled           = var.enabled
  pre_shared_key    = var.authentication_mode == "PSK" ? var.pre_shared_key : ""
  local_ip_address  = var.local_ip_address
  local_networks    = var.local_networks
  remote_ip_address = var.remote_ip_address
  remote_id         = var.remote_id
  remote_networks   = var.remote_networks
  logging           = var.logging

  authentication_mode = var.authentication_mode
  certificate_id      = var.authentication_mode == "CERTIFICATE" ? data.vcd_library_certificate.cert[0].id : null
  ca_certificate_id   = var.authentication_mode == "CERTIFICATE" ? data.vcd_library_certificate.ca-cert[0].id : null
}


