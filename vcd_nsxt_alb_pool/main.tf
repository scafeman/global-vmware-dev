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
  name = var.vdc_group_name
}

data "vcd_nsxt_edgegateway" "edge_gateway" {
  org      = var.vdc_org_name
  owner_id = data.vcd_vdc_group.dcgroup.id
  name     = var.vdc_edge_name
}

data "vcd_library_certificate" "ca-cert" {
  alias = var.ca_certificate_name
}

resource "vcd_nsxt_alb_pool" "alb-pool" {
  org = var.vdc_org_name

  name            = var.pool_name
  edge_gateway_id = data.vcd_nsxt_edgegateway.edge_gateway.id

  description               = var.description
  enabled                   = var.enabled
  algorithm                 = var.algorithm
  default_port              = var.default_port
  graceful_timeout_period   = var.graceful_timeout_period
  passive_monitoring_enabled = var.passive_monitoring_enabled
  ca_certificate_ids        = [data.vcd_library_certificate.ca-cert.id]

  dynamic "persistence_profile" {
    for_each = var.persistence_profile
    content {
      type = persistence_profile.value.type
      value = persistence_profile.value.value
    }
  }

  dynamic "health_monitor" {
    for_each = var.health_monitor
    content {
      type = health_monitor.value.type
    }
  }

  dynamic "member" {
    for_each = var.members
    content {
      enabled    = member.value.enabled
      ip_address = member.value.ip_address
      port       = member.value.port
      ratio      = member.value.ratio
    }
  }
}
