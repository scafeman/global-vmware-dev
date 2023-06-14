terraform {
  required_version = "~> 1.2"

  required_providers {
    vcd = {
      source  = "vmware/vcd"
      version = "~> 3.8"
    }
  }
}

data "vcd_vdc_group" "vdc_group" {
  name      = var.vdc_group_name
}

data "vcd_nsxt_edgegateway" "edge_gateway" {
  org       = var.vdc_org_name
  owner_id  = data.vcd_vdc_group.vdc_group.id
  name      = var.vdc_edge_name
}

data "vcd_network_routed_v2" "segment" {
  for_each        = { for net in var.org_networks : net.name => net }
  edge_gateway_id = data.vcd_nsxt_edgegateway.edge_gateway.id
  name            = each.value.name
}

data "vcd_vm_sizing_policy" "sizing_policy" {
  name = var.vm_sizing_policy_name
}

data "vcd_catalog" "catalog" {
  name = var.catalog_name
}

data "vcd_catalog_vapp_template" "template" {
  catalog_id = data.vcd_catalog.catalog.id
  name       = var.catalog_template_name
}

resource "vcd_vm" "vm" {
  for_each = { for i in range(var.vm_count) : i => i }

  name                    = var.vm_name_format != "" ? format(var.vm_name_format, var.vm_name[each.key % length(var.vm_name)], each.key + 1) : var.vm_name[each.key % length(var.vm_name)]
  computer_name           = var.computer_name_format != "" ? format(var.computer_name_format, var.computer_name[each.key % length(var.computer_name)], each.key + 1) : var.computer_name[each.key % length(var.computer_name)]
  vapp_template_id        = data.vcd_catalog_vapp_template.template.id
  cpu_hot_add_enabled     = var.vm_cpu_hot_add_enabled
  memory_hot_add_enabled  = var.vm_memory_hot_add_enabled
  sizing_policy_id        = data.vcd_vm_sizing_policy.sizing_policy.id
  cpus                    = var.vm_min_cpu

  dynamic "metadata_entry" {
    for_each              = var.vm_metadata_entries

    content {
      key                 = metadata_entry.value.key
      value               = metadata_entry.value.value
      type                = metadata_entry.value.type
      user_access         = metadata_entry.value.user_access
      is_system           = metadata_entry.value.is_system
    }
  }

  dynamic "disk" {
    for_each = can(var.vm_disks) ? slice(var.vm_disks, each.key * var.disks_per_vm, (each.key + 1) * var.disks_per_vm) : []

    content {
      name        = can(disk.value) ? disk.value.name : null
      bus_number  = can(disk.value) ? disk.value.bus_number : null
      unit_number = can(disk.value) ? disk.value.unit_number : null
    }
  }

  dynamic "network" {
    for_each = var.network_interfaces

    content {
      type                = network.value.type
      adapter_type        = network.value.adapter_type
      name                = network.value.name
      ip_allocation_mode  = network.value.ip_allocation_mode
      ip                  = network.value.ip_allocation_mode == "MANUAL" ? element(var.vm_ips, each.key * var.vm_ips_index_multiplier + network.key) : ""
      is_primary          = network.value.is_primary
    }
  }

  dynamic "override_template_disk" {
    for_each = var.override_template_disks

    content {
      bus_type        = override_template_disk.value.bus_type
      size_in_mb      = override_template_disk.value.size_in_mb
      bus_number      = override_template_disk.value.bus_number
      unit_number     = override_template_disk.value.unit_number
      iops            = override_template_disk.value.iops
      storage_profile = override_template_disk.value.storage_profile
    }
  }  

  customization {
    force                               = var.vm_customization_force
    enabled                             = var.vm_customization_enabled
    change_sid                          = var.vm_customization_change_sid
    allow_local_admin_password          = var.vm_customization_allow_local_admin_password
    must_change_password_on_first_login = var.vm_customization_must_change_password_on_first_login
    auto_generate_password              = var.vm_customization_auto_generate_password
    admin_password                      = var.vm_customization_admin_password
    number_of_auto_logons               = var.vm_customization_number_of_auto_logons
    join_domain                         = var.vm_customization_join_domain
    join_org_domain                     = var.vm_customization_join_org_domain
    join_domain_name                    = var.vm_customization_join_domain_name
    join_domain_user                    = var.vm_customization_join_domain_user
    join_domain_password                = var.vm_customization_join_domain_password
    join_domain_account_ou              = var.vm_customization_join_domain_account_ou
    initscript                          = var.vm_customization_initscript
  }
}