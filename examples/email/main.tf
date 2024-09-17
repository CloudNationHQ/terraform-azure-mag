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
      name           = "mag-demo-dev-email"
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
}
