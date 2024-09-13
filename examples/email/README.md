# Default 
This example illustrates the default action group setup, with e-mail notifications setup.

## Types

```hcl
group = object({
  name           = string              
  short_name     = string               
  resource_group = string  
  location       = optional(string, 'global')
  enabled        = optional(bool, true)           
  
  email_receiver = optional(map(object({
    name                    = string
    email_adress            = string
    use_common_alert_schema = optional(bool)
  })))

  tags = optional(object({
    key      = value
  }))
})
```
