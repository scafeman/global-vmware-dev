variable "vdc_org_name" {}

variable "vdc_edge_name" {}

variable "vdc_group_name" {}

variable "ip_sets" {
  type = list(object({
    name            = string
    description     = string
    ip_addresses    = list(string)
  }))
  default = [
    {
      name         = "Segment-01-Network_192.168.0.0/24_IP-Set"
      description  = "Segment-01 Network IP Set"
      ip_addresses = ["192.168.0.0/24"]
    },
    {
      name         = "Segment-02-Network_192.168.1.0/24_IP-Set"
      description  = "Segment-02 Network IP Set"
      ip_addresses = ["192.168.0.0/24"]
    }
  ]
}
