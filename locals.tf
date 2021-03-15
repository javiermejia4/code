locals {
  service = "Custom VPC"
  owner   = "Me"
  name    = "BlackMamba"

  common_tags = {
    owner   = local.owner
    name    = local.name
    service = local.service
  }
}