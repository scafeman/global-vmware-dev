variable "vdc_org_name" {
  type        = string
  description = "Cloud Director Organization Name"
  default     = ""
}

variable "vdc_group_name" {
  type        = string
  description = "Cloud Director Datacenter Group Name"
  default     = ""
}

variable "vdc_name" {
  type        = string
  description = "Cloud Director VDC Name"
  default     = ""
}

variable "vapp_names" {
  type    = list(string)
  default = ["vApp-01", "vApp-02"]
}