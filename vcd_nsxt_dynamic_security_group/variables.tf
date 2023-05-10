variable "vdc_org_name" {}

variable "vdc_group_name" {}

variable "dynamic_security_groups" {
  type = map(object({
    description = string
    criteria    = list(any)
  }))
  default = {
    Web-Servers_Dynamic-SG = {
      description = "Web Servers Dynamic Security Group"
      criteria    = [
        {
          type     = "VM_TAG"
          operator = "EQUALS"
          value    = "web"
        }
      ]
    },
    Database-Servers_Dynamic-SG = {
      description = "Database Servers Dynamic Security Group"
      criteria    = [
        {
          type     = "VM_TAG"
          operator = "EQUALS"
          value    = "db"
        }
      ]
    }
  }
}
