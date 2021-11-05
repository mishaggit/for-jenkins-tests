locals {
  config = yamldecode(file(var.configpath))
  common_config = yamldecode(file(var.common_configpath))
  #list_node_pool in config file for all clusters only for node_pool config
  list_node_pool = flatten ([ 
    for gke_configs in local.config : [
      for node_pool_configs in lookup(gke_configs, "node_pools", []) : [
        {
          cluster_name = gke_configs["cluster_name"]
          location = gke_configs["location"]
          name = node_pool_configs["name"]
          machine_type = node_pool_configs["machine_type"]
          initial_node_count = node_pool_configs["initial_node_count"]
          autoscaling = lookup(node_pool_configs, "autoscaling", null)
          min_node_count = lookup(node_pool_configs, "min_node_count", 1)
          max_node_count = lookup(node_pool_configs, "max_node_count", 2)
          disk_size_gb = lookup(node_pool_configs, "disk_size_gb", 10)
          disk_type = lookup(node_pool_configs, "disk_type", "pd-standard")
          service_account_email = node_pool_configs["service_account_email"]
        }
      ]
    ]
  ])
}