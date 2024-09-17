variable "groups" {
  description = "describes monitor action group related configuration"
  type        = any
}

variable "location" {
  description = "default azure region to be used."
  type        = string
  default     = null
}

variable "resource_group" {
  description = "default resource group to be used."
  type        = string
  default     = null
}

variable "tags" {
  description = "default tags to be added to the resources"
  type        = map(string)
  default     = {}
}
