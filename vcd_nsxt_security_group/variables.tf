variable "vdc_org_name" {}

variable "vdc_group_name" {}

variable "vdc_edge_name" {}

variable "org_network_names" {
  description         = "List of network names to be fetched"
  type                = list(object({
    name              = string
  }))
  default             = []
}

variable "security_groups" {
  description         = "Map of security groups with names, descriptions, and corresponding org network names"
  type                = map(object({
    description       = string
    org_network_names = list(string)
  }))
  default             = {}
}
