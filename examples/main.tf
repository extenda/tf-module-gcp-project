module service-account {
  source = "../modules/service-account"
  project_id = "project-test-id"
  display_name = "Service Account"
services = {
    "service1" = [ "role0", "role1" ]
    "service2" = [ "role2", "role3" ]
  }
}
