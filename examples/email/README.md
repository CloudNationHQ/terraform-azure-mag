# Default
This example illustrates the default setup, in its simplest form.

## Types

```hcl
groups = map(object({
  name           = string
  short_name     = string
  resource_group = string
  location       = optional(string, "global")
  enabled        = optional(bool, true)
  email_receiver = optional(map(object({
    name                    = string
    email_address           = string
    use_common_alert_schema = optional(bool)
  })))
  tags = optional(map(string))
}))
```
