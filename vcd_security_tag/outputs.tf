output "tag_vm_mapping" {
  value = {
    for tag_name, vm_names in var.security_tags : tag_name => vm_names
  }
}
