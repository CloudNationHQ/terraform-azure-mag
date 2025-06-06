# Monitor Action Groups

This terraform module simplifies the process of creating a monitor action groups on azure with customizable options and features, offering a flexible and powerful solution for managing action groups through code.

## Features

Offers support for action groups with e-mail and phone notifications.

Utilization of terratest for robust validation.

<!-- BEGIN_TF_DOCS -->
## Requirements

The following requirements are needed by this module:

- <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) (~> 1.0)

- <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) (~> 4.0)

- <a name="requirement_random"></a> [random](#requirement\_random) (~> 3.6)

## Providers

The following providers are used by this module:

- <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) (~> 4.0)

## Resources

The following resources are used by this module:

- [azurerm_monitor_action_group.groups](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_action_group) (resource)

## Required Inputs

The following input variables are required:

### <a name="input_groups"></a> [groups](#input\_groups)

Description: Contains all monitor action group configuration

Type:

```hcl
map(object({
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
```

## Optional Inputs

The following input variables are optional (have default values):

### <a name="input_location"></a> [location](#input\_location)

Description: default azure region to be used.

Type: `string`

Default: `null`

### <a name="input_naming"></a> [naming](#input\_naming)

Description: contains naming convention

Type: `map(string)`

Default: `{}`

### <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name)

Description: default resource group to be used.

Type: `string`

Default: `null`

### <a name="input_tags"></a> [tags](#input\_tags)

Description: default tags to be added to the resources

Type: `map(string)`

Default: `{}`

## Outputs

The following outputs are exported:

### <a name="output_groups"></a> [groups](#output\_groups)

Description: monitor action group configuration specifics
<!-- END_TF_DOCS -->

## Goals

For more information, please see our [goals and non-goals](./GOALS.md).

## Testing

For more information, please see our testing [guidelines](./TESTING.md)

## Notes

Using a dedicated module, we've developed a naming convention for resources that's based on specific regular expressions for each type, ensuring correct abbreviations and offering flexibility with multiple prefixes and suffixes.

Full examples detailing all usages, along with integrations with dependency modules, are located in the examples directory.

To update the module's documentation run `make doc`

## Contributors

We welcome contributions from the community! Whether it's reporting a bug, suggesting a new feature, or submitting a pull request, your input is highly valued.

For more information, please see our contribution [guidelines](./CONTRIBUTING.md). <br><br>

<a href="https://github.com/cloudnationhq/terraform-azure-mag/graphs/contributors">
  <img src="https://contrib.rocks/image?repo=cloudnationhq/terraform-azure-mag" />
</a>

## License

MIT Licensed. See [LICENSE](./LICENSE) for full details.

## References

- [Documentation](https://learn.microsoft.com/en-us/azure/azure-monitor/alerts/action-groups)
- [Rest Api](https://learn.microsoft.com/en-us/rest/api/monitor/action-groups)
- [Rest Api Specs](https://github.com/Azure/azure-rest-api-specs/tree/main/specification/monitor/resource-manager)
