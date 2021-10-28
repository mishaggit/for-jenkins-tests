resource "google_service_account" "testserviceaccount" {
  for_each = local.config

  account_id   = each.value["account_id"]
  display_name = each.value["display_name"]
  #email = each.value["email"]
  #id = each.value["id"]
  #name = each.value["name"]
  project = each.value["project"]
  #unique_id = each.value["unique_id"]
}
/*terraform {
  backend "gcs" {
    bucket  = "mybucket-7777777"
    prefix  = "testprefixstate"
  }
}*/
output "testcheck-for-project" {
  value = {
    #for
    value = lookup(local.config.test_terraform2, "project", "NOT_EXIST")
  }
  #value = lookup(local.config["users"], "test_terraform", "NOT_EXIST")  
}