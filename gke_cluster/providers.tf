provider "google" {
  project     = local.common_config["project_id"]
  region      = local.common_config["region"]
  zone        = local.common_config["zone"]
}