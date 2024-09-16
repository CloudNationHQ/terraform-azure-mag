module "naming" {
  source  = "cloudnationhq/naming/azure"
  version = "~> 0.1"

  suffix = ["demo", "dev"]
}

module "rg" {
  source  = "cloudnationhq/rg/azure"
  version = "~> 0.1"

  groups = {
    demo = {
      name   = module.naming.resource_group.name
      region = "westeurope"
    }
  }
}

module "mag" {
  source  = "cloudnationhq/mag/azure"
  version = "~> 1.0"

  group = {
    name           = module.naming.monitor_action_group.name
    resource_group = module.rg.groups.demo.name
    short_name     = "mag-email"

    email_receiver = {
      email1 = {
        name          = "send to admin"
        email_address = "admin@contoso.com"
      }
      email2 = {
        name          = "send to support"
        email_address = "support@contoso.com"
      }
    }
  }
}
