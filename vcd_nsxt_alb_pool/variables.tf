variable "vdc_org_name" {}

variable "vdc_group_name" {}

variable "vdc_edge_name" {}

variable "pool_name" {
  description = "A name for NSX-T ALB Pool"
  type        = string
}



variable "members" {
  description = "List of pool members"
  type        = list(object({
    enabled    = bool
    ip_address = string
    port       = number
    ratio      = number
  }))
}

variable "member_group_id" {
  description = "A reference to NSX-T IP Set"
  type        = string
  default     = ""
}

variable "description" {
  description = "An optional description NSX-T ALB Pool"
  type        = string
  default     = ""
}

variable "enabled" {
  description = "Boolean value if NSX-T ALB Pool should be enabled"
  type        = bool
  default     = true
}

variable "algorithm" {
  description = "Optional algorithm for choosing pool members"
  type        = string
  default     = "LEAST_CONNECTIONS"
}

variable "default_port" {
  description = "Default Port defines destination server port used by the traffic sent to the member"
  type        = number
  default     = 80
}

variable "graceful_timeout_period" {
  description = "Maximum time in minutes to gracefully disable pool member"
  type        = string
  default     = "1"
}

variable "passive_monitoring_enabled" {
  description = "defines if client traffic should be used to check if pool member is up or down"
  type        = bool
  default     = true
}

variable "ca_certificate_name" {
  description = "The name of the CA certificate"
  type        = string
  default     = ""
}

variable "persistence_profile" {
  description = "Persistence profile to ensure that the same user sticks to the same server for a desired duration of time"
  type = list(object({
    type = string
    value = string
  }))
}

variable "health_monitor" {
  description = "A block to define health monitor"
  type = list(object({
    type = string
  }))
}