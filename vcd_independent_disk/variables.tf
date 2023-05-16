variable "vdc_org_name" {}

variable "disk_params" {
  description = "List of maps containing disk parameters. Each map item describes a single disk."
  type = list(object({
    name            = string
    size_in_mb      = string
    bus_type        = string
    bus_sub_type    = string
    storage_profile = string
    sharing_type    = string
    metadata        = list(object({
      key         = string
      value       = string
      type        = string
      user_access = string
      is_system   = bool
    }))
  }))

  default = [
    {
      name              = "DataDisk01"
      size_in_mb        = "102400"
      bus_type          = "SCSI"
      bus_sub_type      = "lsilogicsas"
      storage_profile   = "Standard"
      sharing_type      = "None"
      metadata          = []
    },
    {
      name              = "DataDisk02"
      size_in_mb        = "204800"
      bus_type          = "SCSI"
      bus_sub_type      = "lsilogicsas"
      storage_profile   = "Performance"
      sharing_type      = "None"
      metadata          = []
    }
  ]
}
