variable "vdc_org_name" {}

variable "security_tags" {
  description = "Map of security tags and their corresponding VM names"
  type        = map(list(string))
  default     = {}
}

variable "vm_names" {
  description = "List of VM names that the security tag is going to be applied to"
  type        = list(string)
  default     = []
}
