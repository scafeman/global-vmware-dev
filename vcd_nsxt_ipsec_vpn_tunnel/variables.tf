variable "vdc_org_name" {}

variable "vdc_group_name" {}

variable "vdc_edge_name" {}

variable "name" {
  type = string
}

variable "description" {
  type = string
  default = ""
}

variable "enabled" {
  type = bool
  default = true
}

variable "pre_shared_key" {
  type = string
  default = ""
}

variable "local_ip_address" {
  type = string
}

variable "local_networks" {
  type = list(string)
}

variable "remote_ip_address" {
  type = string
}

variable "remote_id" {
  type = string
}

variable "remote_networks" {
  type = list(string)
  default = ["0.0.0.0/0"]
}

variable "logging" {
  default = false
}

variable "authentication_mode" {
  default = "PSK"
}

variable "certificate_alias" {
  default = ""
}

variable "ca_certificate_alias" {
  default = ""
}

variable "certificate_id" {
  default = ""
}

variable "ca_certificate_id" {
  default = ""
}

