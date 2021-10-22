locals {
  config = yamldecode(file(var.configpath))
  common_config = yamldecode(file(var.common_configpath))
}