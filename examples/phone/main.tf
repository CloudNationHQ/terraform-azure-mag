module "naming" {
  source  = "cloudnationhq/naming/azure"
  version = "~> 0.1"

  suffix = ["demo", "dev"]
}

module "rg" {
  source  = "cloudnationhq/rg/azure"
  version = "~> 1.0"

  groups = {
    demo = {
      name     = module.naming.resource_group.name_unique
      location = "westeurope"
    }
  }
}

module "mag" {
  source  = "cloudnationhq/mag/azure"
  version = "~> 1.0"

  groups = {
    demo = {
      name           = module.naming.monitor_action_group.name
      resource_group = module.rg.groups.demo.name
      short_name     = "mag-phone"

      sms_receiver = {
        sms1 = {
          name         = "sms to john"
          phone_number = "612345678"
          country_code = 31
        }
        sms2 = {
          name         = "sms to jane"
          phone_number = "687654321"
          country_code = 31
        }
      }

      azure_app_push_receiver = {
        push1 = {
          name          = "push to john"
          email_address = "john.doe@contoso.com"
        }
      }

      voice_receiver = {
        voice1 = {
          name         = "voice to john"
          phone_number = "612345678"
          country_code = 31
        }
        voice2 = {
          name         = "voice to jane"
          phone_number = "687654321"
          country_code = 31
        }
      }
    }
  }
}
