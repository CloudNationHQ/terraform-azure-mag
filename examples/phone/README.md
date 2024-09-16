# Default 
This example illustrates the default action group setup, with a phone SMS, Voice and Push notifications setup.

## Types

```hcl
group = object({
  name           = string              
  short_name     = string               
  resource_group = string  
  location       = optional(string, 'global')
  enabled        = optional(bool, true)           
  
  sms_receiver = optional(map(object({
    name         = string
    phone_number = string
    country_code = number
  })))

  voice_receiver = optional(map(object({
    name         = string
    phone_number = string
    country_code = number
  })))

   azure_app_push_receiver = optional(map(object({
    name          = string
    email_address = string
  })))

  tags = optional(object({
    key      = value
  }))
})
```
