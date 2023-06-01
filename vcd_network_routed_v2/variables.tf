variable "vdc_group_name" {}

variable "vdc_org_name" {}

variable "vdc_edge_name" {}

# Define a map of segments with their configurations
variable "segments" {
  type = map(object({
    gateway         = string
    prefix_length   = number
    dns1            = string
    dns2            = string
    dns_suffix      = string
    start_address   = string
    end_address     = string
  }))
  default = {
    Segment-01 = {
      gateway         = "192.168.0.1"
      prefix_length   = 24
      dns1            = "192.168.255.228"
      dns2            = ""
      dns_suffix      = "domain.com"
      start_address   = "192.168.0.50"
      end_address     = "192.168.0.100"
    },
    Segment-02 = {
      gateway         = "192.168.1.1"
      prefix_length   = 24
      dns1            = "192.168.255.228"
      dns2            = ""
      dns_suffix      = "domain.com"
      start_address   = "192.168.1.50"
      end_address     = "192.168.1.100"
    }
  }
}