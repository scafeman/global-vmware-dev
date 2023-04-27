output "vm_names" {
  value = [for i in range(var.vm_count) : vcd_vapp_vm.vm[i].name]
}

output "vm_ips" {
  value = [for i in range(var.vm_count) : vcd_vapp_vm.vm[i].network.*.ip]
}

output "vm_computer_names" {
  value = [for i in range(var.vm_count) : vcd_vapp_vm.vm[i].computer_name]
}

output "vm_metadata_entries" {
  value = [for i in range(var.vm_count) : { for entry in vcd_vapp_vm.vm[i].metadata_entry : entry.key => entry.value } ]
}

output "vm_count" {
  value = var.vm_count
}

output "vm_sizing_policy_name" {
    value = data.vcd_vm_sizing_policy.sizing_policy.name
}
