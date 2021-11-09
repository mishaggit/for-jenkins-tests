resource "google_container_cluster" "primary" {
  for_each = local.config

  name     = each.value["cluster_name"]
  location = each.value["location"]
  #machine_type = each.value["machine_type"]
  logging_service = each.value["logging_service"]
  monitoring_service = each.value["monitoring_service"]
  #oauth_scopes = each.value["oauth_scopes"]
  #service_account_email = each.value["service_account_email"]
  # We can't create a cluster with no node pool defined, but we want to only use
  # separately managed node pools. So we create the smallest possible default
  # node pool and immediately delete it.
  remove_default_node_pool = true
  initial_node_count       = 1
}
resource "google_container_node_pool" "test_node_pool" {
  #for_each = local.list_node_pool
  for_each = {
    for test_node_pool in local.list_node_pool :
    join(":", [
      test_node_pool.cluster_name,
      test_node_pool.location,
      test_node_pool.name,
      ]
    ) => test_node_pool
  }
  cluster    = each.value.cluster_name
  location   = each.value.location
  name       = each.value.name
  node_count = each.value.initial_node_count
  #autoscaling = each.value.autoscaling
  #min_node_count = each.value.min_node_count
  #max_node_count = each.value.max_node_count
  node_config {
    preemptible  = true
    machine_type = each.value.machine_type
    disk_size_gb = each.value.disk_size_gb
    disk_type = each.value.disk_type

    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    # service_account = google_service_account.testserviceaccount.email
    service_account = each.value.service_account_email
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}