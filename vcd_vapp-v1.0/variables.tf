variable "vcd_user" {
  description = "Cloud Director Username"
  type        = string
  sensitive   = true
  default     = ""
}
variable "vcd_pass" {
  description = "Cloud Director Password"
  type        = string
  sensitive   = true
  default     = ""
}
variable "vcd_url" {
  description = "Cloud Director URL"
  default = "https://us1.rsvc.rackspace.com/api"
}
variable "vcd_max_retry_timeout" {
  default = 90
}
variable "vcd_allow_unverified_ssl" {
  default = true
}

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