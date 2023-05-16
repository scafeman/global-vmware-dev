output "independent_disks" {
  value = { for disk in vcd_independent_disk.disk : disk.id => {
    name                = disk.name
    size_in_mb          = disk.size_in_mb
    bus_type            = disk.bus_type
    bus_sub_type        = disk.bus_sub_type
    storage_profile     = disk.storage_profile
    sharing_type        = disk.sharing_type
    description         = disk.description
    metadata            = disk.metadata
    is_attached         = disk.is_attached
  }}
}
