variable "groups" {
  description = "Contains all monitor action group configuration"
  type = map(object({
    name                = optional(string, null)
    resource_group_name = optional(string, null)
    location            = optional(string, null)
    short_name          = string
    enabled             = optional(bool, true)
    tags                = optional(map(string))
    arm_role_receiver = optional(map(object({
      name                    = optional(string, null)
      role_id                 = string
      use_common_alert_schema = optional(bool, null)
    })), {})
    automation_runbook_receiver = optional(map(object({
      name                    = optional(string, null)
      automation_account_id   = string
      runbook_name            = string
      webhook_resource_id     = string
      is_global_runbook       = optional(bool, true)
      service_uri             = string
      use_common_alert_schema = optional(bool, null)
    })), {})
    azure_app_push_receiver = optional(map(object({
      name          = optional(string, null)
      email_address = string
    })), {})
    azure_function_receiver = optional(map(object({
      name                     = optional(string, null)
      function_app_resource_id = string
      function_name            = string
      http_trigger_url         = string
      use_common_alert_schema  = optional(bool, null)
    })), {})
    email_receiver = optional(map(object({
      name                    = optional(string, null)
      email_address           = string
      use_common_alert_schema = optional(bool, null)
    })), {})
    event_hub_receiver = optional(map(object({
      name                    = optional(string, null)
      event_hub_namespace     = optional(string, null)
      event_hub_name          = optional(string, null)
      subscription_id         = optional(string, null)
      tenant_id               = optional(string, null)
      use_common_alert_schema = optional(bool, null)
    })), {})
    itsm_receiver = optional(map(object({
      name                 = optional(string, null)
      workspace_id         = string
      connection_id        = string
      ticket_configuration = any
      region               = string
    })), {})
    logic_app_receiver = optional(map(object({
      name                    = optional(string, null)
      resource_id             = string
      callback_url            = string
      use_common_alert_schema = optional(bool, null)
    })), {})
    sms_receiver = optional(map(object({
      name         = optional(string, null)
      country_code = string
      phone_number = string
    })), {})
    voice_receiver = optional(map(object({
      name         = optional(string, null)
      country_code = string
      phone_number = string
    })), {})
    webhook_receiver = optional(map(object({
      name                    = optional(string, null)
      service_uri             = string
      use_common_alert_schema = optional(bool, null)
    })), {})
  }))

  validation {
    condition = alltrue([
      for group_key, group in var.groups : length(group.short_name) <= 12
    ])
    error_message = "short_name must be 12 characters or less for all action groups."
  }

  validation {
    condition = alltrue([
      for group_key, group in var.groups : can(regex("^[a-zA-Z0-9_-]+$", group.short_name))
    ])
    error_message = "short_name can only contain letters, numbers, underscores, and hyphens."
  }

  validation {
    condition = alltrue([
      for group_key, group in var.groups : alltrue([
        for receiver_key, receiver in try(group.sms_receiver, {}) :
        can(regex("^[0-9]+$", receiver.country_code)) && can(regex("^[0-9]+$", receiver.phone_number))
      ])
    ])
    error_message = "SMS receiver country_code and phone_number must contain only digits."
  }

  validation {
    condition = alltrue([
      for group_key, group in var.groups : alltrue([
        for receiver_key, receiver in try(group.voice_receiver, {}) :
        can(regex("^[0-9]+$", receiver.country_code)) && can(regex("^[0-9]+$", receiver.phone_number))
      ])
    ])
    error_message = "Voice receiver country_code and phone_number must contain only digits."
  }

  validation {
    condition = alltrue([
      for group_key, group in var.groups : alltrue([
        for receiver_key, receiver in try(group.email_receiver, {}) :
        can(regex("^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$", receiver.email_address))
      ])
    ])
    error_message = "Email receiver email_address must be a valid email format."
  }

  validation {
    condition = alltrue([
      for group_key, group in var.groups : alltrue([
        for receiver_key, receiver in try(group.webhook_receiver, {}) :
        can(regex("^https://", receiver.service_uri))
      ])
    ])
    error_message = "Webhook receiver service_uri must start with https://."
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

variable "naming" {
  description = "contains naming convention"
  type        = map(string)
  default     = {}
}
