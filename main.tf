resource "azurerm_monitor_action_group" "groups" {
  for_each = var.groups

  resource_group_name = coalesce(
    lookup(
      each.value, "resource_group_name", null
    ), var.resource_group_name
  )

  location = try(
    each.value.location, var.location, null
  )

  name = coalesce(
    each.value.name, try(
      join("-", [var.naming.monitor_action_group, each.key]), null
    ), each.key
  )

  short_name = each.value.short_name
  enabled    = each.value.enabled

  tags = coalesce(
    each.value.tags, var.tags
  )

  dynamic "arm_role_receiver" {
    for_each = try(
      each.value.arm_role_receiver, {}
    )

    content {
      name = coalesce(
        arn_role_receiver.value.name, arn_role_receiver.key
      )

      role_id                 = arm_role_receiver.value.role_id
      use_common_alert_schema = arm_role_receiver.value.use_common_alert_schema
    }
  }

  dynamic "automation_runbook_receiver" {
    for_each = try(
      each.value.automation_runbook_receiver, {}
    )

    content {
      name = coalesce(
        automation_runbook_receiver.value.name, automation_runbook_receiver.key
      )

      automation_account_id   = automation_runbook_receiver.value.automation_account_id
      runbook_name            = automation_runbook_receiver.value.runbook_name
      webhook_resource_id     = automation_runbook_receiver.value.webhook_resource_id
      is_global_runbook       = automation_runbook_receiver.value.is_global_runbook
      service_uri             = automation_runbook_receiver.value.service_uri
      use_common_alert_schema = automation_runbook_receiver.value.use_common_alert_schema
    }
  }

  dynamic "azure_app_push_receiver" {
    for_each = try(
      each.value.azure_app_push_receiver, {}
    )

    content {
      name = coalesce(
        azure_app_push_receiver.value.name, azure_app_push_receiver.key
      )

      email_address = azure_app_push_receiver.value.email_address
    }
  }

  dynamic "azure_function_receiver" {
    for_each = try(
      each.value.azure_function_receiver, {}
    )

    content {
      name = coalesce(
        azure_function_receiver.value.name, azure_function_receiver.key
      )

      function_app_resource_id = azure_function_receiver.value.function_app_resource_id
      function_name            = azure_function_receiver.value.function_name
      http_trigger_url         = azure_function_receiver.value.http_trigger_url
      use_common_alert_schema  = azure_function_receiver.value.use_common_alert_schema
    }
  }

  dynamic "email_receiver" {
    for_each = try(
      each.value.email_receiver, {}
    )

    content {
      name = coalesce(
        email_receiver.value.name, email_receiver.key
      )

      email_address           = email_receiver.value.email_address
      use_common_alert_schema = email_receiver.value.use_common_alert_schema
    }
  }

  dynamic "event_hub_receiver" {
    for_each = try(
      each.value.event_hub_receiver, {}
    )

    content {
      name = coalesce(
        event_hub_receiver.value.name, event_hub_receiver.key
      )

      event_hub_namespace     = event_hub_receiver.value.event_hub_namespace
      event_hub_name          = event_hub_receiver.value.event_hub_name
      subscription_id         = event_hub_receiver.value.subscription_id
      tenant_id               = event_hub_receiver.value.tenant_id
      use_common_alert_schema = event_hub_receiver.value.use_common_alert_schema
    }
  }

  dynamic "itsm_receiver" {
    for_each = try(
      each.value.itsm_receiver, {}
    )

    content {
      name = coalesce(
        itsm_receiver.value.name, itsm_receiver.key
      )

      workspace_id  = itsm_receiver.value.workspace_id
      connection_id = itsm_receiver.value.connection_id
      region        = itsm_receiver.value.region

      ticket_configuration = jsonencode(
        itsm_receiver.value.ticket_configuration
      )
    }
  }

  dynamic "logic_app_receiver" {
    for_each = try(
      each.value.logic_app_receiver, {}
    )

    content {
      name = coalesce(
        logic_app_receiver.value.name, logic_app_receiver.key
      )

      resource_id             = logic_app_receiver.value.resource_id
      callback_url            = logic_app_receiver.value.callback_url
      use_common_alert_schema = logic_app_receiver.value.use_common_alert_schema
    }
  }

  dynamic "sms_receiver" {
    for_each = try(
      each.value.sms_receiver, {}
    )

    content {
      name = coalesce(
        sms_receiver.value.name, sms_receiver.key
      )

      country_code = sms_receiver.value.country_code
      phone_number = sms_receiver.value.phone_number
    }
  }

  dynamic "voice_receiver" {
    for_each = try(
      each.value.voice_receiver, {}
    )

    content {
      name = coalesce(
        voice_receiver.value.name, voice_receiver.key
      )

      country_code = voice_receiver.value.country_code
      phone_number = voice_receiver.value.phone_number
    }
  }

  dynamic "webhook_receiver" {
    for_each = try(
      each.value.webhook_receiver, {}
    )

    content {
      name = coalesce(
        webhook_receiver.value.name, webhook_receiver.key
      )

      service_uri             = webhook_receiver.value.service_uri
      use_common_alert_schema = webhook_receiver.value.use_common_alert_schema

      dynamic "aad_auth" {
        for_each = try(
          { aad = webhook_receiver.value.aad_auth }, {}
        )

        content {
          object_id      = aad_auth.value.object_id
          identifier_uri = aad_auth.value.identifier_uri
          tenant_id      = aad_auth.value.tenant_id
        }
      }
    }
  }
}

