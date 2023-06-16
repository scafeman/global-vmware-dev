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
  name      = var.vdc_group_name
}

data "vcd_nsxt_edgegateway" "edge_gateway" {
  org      = var.vdc_org_name
  owner_id = data.vcd_vdc_group.dcgroup.id
  name     = var.vdc_edge_name
}

data "vcd_library_certificate" "ca-cert" {
  for_each = var.ca_certificate_name != "" ? { ca_cert = var.ca_certificate_name } : {}
  alias    = each.value
}

data "vcd_nsxt_ip_set" "ip-set" {
  for_each         = var.member_group_ip_set_name != "" ? { ip_set = var.member_group_ip_set_name } : {}
  org              = var.vdc_org_name
  edge_gateway_id  = data.vcd_nsxt_edgegateway.edge_gateway.id
  name             = each.value
}

resource "vcd_nsxt_alb_pool" "alb-pool" {
  org                         = var.vdc_org_name
  name                        = var.pool_name
  edge_gateway_id             = data.vcd_nsxt_edgegateway.edge_gateway.id
  description                 = var.description
  enabled                     = var.enabled
  algorithm                   = var.algorithm
  default_port                = var.default_port
  graceful_timeout_period     = var.graceful_timeout_period
  passive_monitoring_enabled  = var.passive_monitoring_enabled
  ca_certificate_ids          = var.ca_certificate_name != "" ? [data.vcd_library_certificate.ca-cert["ca_cert"].id] : []
  cn_check_enabled            = var.cn_check_enabled
  domain_names                = var.domain_names

  dynamic "persistence_profile" {
    for_each  = var.persistence_profile
    content {
      type    = persistence_profile.value.type
      value   = persistence_profile.value.type == "HTTP_COOKIE" || persistence_profile.value.type == "CUSTOM_HTTP_HEADER" || persistence_profile.value.type == "APP_COOKIE" ? persistence_profile.value.value : ""
    }
  }

  dynamic "health_monitor" {
    for_each  = var.health_monitor
    content {
      type    = health_monitor.value.type
    }
  }

  dynamic "member" {
    for_each      = var.use_member_group ? [] : var.members
    content {
      enabled     = member.value.enabled
      ip_address  = member.value.ip_address
      port        = member.value.port
      ratio       = member.value.ratio
    }
  }
  
  member_group_id = var.use_member_group ? data.vcd_nsxt_ip_set.ip-set["ip_set"].id : null
}
