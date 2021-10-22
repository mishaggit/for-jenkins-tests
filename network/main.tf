resource "google_compute_network" "test-custom" {
  name                    = local.config["network"]
  auto_create_subnetworks = local.config["auto_create_subnetworks"]
}

resource "google_compute_subnetwork" "network-with-private-secondary-ip-ranges" {
  name          = local.config["subnetwork"]
  ip_cidr_range = local.config["ip_cidr_range1"]
  region        = local.config["region"]
  network       = google_compute_network.test-custom.id
  secondary_ip_range {
    range_name    = local.config["ip_range_pods_name"]
    ip_cidr_range = local.config["ip_cidr_range2"]
  }
}