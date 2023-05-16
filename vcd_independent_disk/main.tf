terraform {
  required_version = "~> 1.2"

  required_providers {
    vcd = {
      source  = "vmware/vcd"
      version = "~> 3.8"
    }
  }
}

resource "vcd_independent_disk" "disk" {
  count             = length(var.disk_params)
  name              = var.disk_params[count.index]["name"]
  size_in_mb        = var.disk_params[count.index]["size_in_mb"]
  bus_type          = var.disk_params[count.index]["bus_type"]
  bus_sub_type      = var.disk_params[count.index]["bus_sub_type"]
  storage_profile   = var.disk_params[count.index]["storage_profile"]
  sharing_type      = var.disk_params[count.index]["sharing_type"]

  dynamic "metadata_entry" {
    for_each = var.disk_params[count.index]["metadata"]
    content {
      key         = metadata_entry.value["key"]
      value       = metadata_entry.value["value"]
      type        = metadata_entry.value["type"]
      user_access = metadata_entry.value["user_access"]
      is_system   = metadata_entry.value["is_system"]
    }
  }
}
