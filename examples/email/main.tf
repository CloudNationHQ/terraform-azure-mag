module "naming" {
  source  = "cloudnationhq/naming/azure"
  version = "~> 0.24"

  suffix = ["demo", "dev"]
}

module "rg" {
  source  = "cloudnationhq/rg/azure"
  version = "~> 2.0"

  groups = {
    demo = {
      name     = module.naming.resource_group.name_unique
      location = "westeurope"
    }
  }
}

module "mag" {
  source  = "cloudnationhq/mag/azure"
  version = "~> 3.0"

  groups = {
    demo = {
      name                = "mag-demo-dev-email"
      resource_group_name = module.rg.groups.demo.name
      short_name          = "mag-email"

      email_receiver = {
        email1 = {
          email_address = "admin@contoso.com"
        }
        email2 = {
          email_address = "support@contoso.com"
        }
      }
    }
  }
}
