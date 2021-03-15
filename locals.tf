locals {
  owner   = "Me"
  name    = "BlackMamba"
  service = "Bastion & Custom VPC"

  common_tags = {
    owner   = local.owner
    name    = local.name
    service = local.service
  }
}