output "all_vm_info" {
  value = {
    for vm in vcd_vapp_vm.this :
    vm.name => {
      ip_address     = vm.ip
      computer_name  = vm.computer_name
      metadata       = vm.metadata_entry
      sizing_policy  = data.vcd_vm_sizing_policy.sizing_policy.name
    }
  }
}
