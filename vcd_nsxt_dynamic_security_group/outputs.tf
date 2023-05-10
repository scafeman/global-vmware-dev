output "dynamic_security_groups" {
  description = "Information about the created Dynamic Security Groups"
  value = {
    for k, dynamic_security_group in vcd_nsxt_dynamic_security_group.group : k => {
      id          = dynamic_security_group.id
      name        = dynamic_security_group.name
      description = dynamic_security_group.description
      member_vms  = dynamic_security_group.member_vms
    }
  }
}
