# Connect to the VMware Cloud Director Provider
provider "vcd" {
user                  = var.vcd_user
password              = var.vcd_pass
auth_type             = "integrated"
org                   = var.vdc_org_name
vdc                   = var.vdc_name
url                   = var.vcd_url
max_retry_timeout     = var.vcd_max_retry_timeout
allow_unverified_ssl  = var.vcd_allow_unverified_ssl
}

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