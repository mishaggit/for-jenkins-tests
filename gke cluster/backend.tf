terraform {
  backend "gcs" {
    bucket  = "mybucket-7777777"
    prefix  = "gke_cluster"
  }
}