variable "groups" {
  description = "Contains all monitor action group configuration"
  type = map(object({
    name                = string
    resource_group_name = optional(string)
    location            = optional(string)
    short_name          = string
    enabled             = optional(bool)
    tags                = optional(map(string))
    arm_role_receiver = optional(map(object({
      name                    = optional(string)
      role_id                 = string
      use_common_alert_schema = optional(bool)
    })), {})
    automation_runbook_receiver = optional(map(object({
      name                    = optional(string)
      automation_account_id   = string
      runbook_name            = string
      webhook_resource_id     = string
      is_global_runbook       = bool
      service_uri             = string
      use_common_alert_schema = optional(bool)
    })), {})
    azure_app_push_receiver = optional(map(object({
      name          = optional(string)
      email_address = string
    })), {})
    azure_function_receiver = optional(map(object({
      name                     = optional(string)
      function_app_resource_id = string
      function_name            = string
      http_trigger_url         = string
      use_common_alert_schema  = optional(bool)
    })), {})
    email_receiver = optional(map(object({
      name                    = optional(string)
      email_address           = string
      use_common_alert_schema = optional(bool)
    })), {})
    event_hub_receiver = optional(map(object({
      name                    = optional(string)
      event_hub_namespace     = optional(string)
      event_hub_name          = optional(string)
      subscription_id         = optional(string)
      tenant_id               = optional(string)
      use_common_alert_schema = optional(bool)
    })), {})
    itsm_receiver = optional(map(object({
      name                 = optional(string)
      workspace_id         = string
      connection_id        = string
      ticket_configuration = any
      region               = string
    })), {})
    logic_app_receiver = optional(map(object({
      name                    = optional(string)
      resource_id             = string
      callback_url            = string
      use_common_alert_schema = optional(bool)
    })), {})
    sms_receiver = optional(map(object({
      name         = optional(string)
      country_code = string
      phone_number = string
    })), {})
    voice_receiver = optional(map(object({
      name         = optional(string)
      country_code = string
      phone_number = string
    })), {})
    webhook_receiver = optional(map(object({
      name                    = optional(string)
      service_uri             = string
      use_common_alert_schema = optional(bool)
    })), {})
  }))

  validation {
    condition = alltrue([
      for group in var.groups : group.location != null || var.location != null
    ])
    error_message = "location must be provided either in the group object or as a separate variable."
  }

  validation {
    condition = alltrue([
      for group in var.groups : group.resource_group_name != null || var.resource_group_name != null
    ])
    error_message = "resource group name must be provided either in the group object or as a separate variable."
  }
}

variable "location" {
  description = "default azure region to be used."
  type        = string
  default     = null
}

variable "resource_group_name" {
  description = "default resource group to be used."
  type        = string
  default     = null
}

variable "tags" {
  description = "default tags to be added to the resources"
  type        = map(string)
  default     = {}
}
