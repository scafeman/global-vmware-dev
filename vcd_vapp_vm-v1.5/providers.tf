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